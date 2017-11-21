parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

parse_git_dirty() {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]]; then
    echo '\[\e[01;31m\]\342\234\227'
  else
    echo '\[\e[01;32m\]\342\234\223'
  fi
}

set_prompt () {
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    PS1="\n"
    if [[ $EUID == 0 ]]; then
        PS1+="$Red\\h"
    else
        PS1+="$Blue\\u"
    fi

    PS1+="$White in "

    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    PS1+="$Green\\w"
    if [ -n "$(parse_git_branch)" ]; then
      PS1+="$White on "
      PS1+="$Blue$(parse_git_branch)"
      PS1+="$(parse_git_dirty)"
    else
      PS1+=" "
    fi
    PS1+="\n$Red\\\$$Reset "
}
PROMPT_COMMAND='set_prompt'

shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
HISTTIMEFORMAT='%F %T '
HISTCONTROL="erasedups:ignoreboth"
HISTSIZE=500000
HISTFILESIZE=100000



# Neovim setup
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export XDG_CONFIG_HOME=$HOME
export EDITOR=vim

# Aliases
alias nv=nvim
alias nvi=nvim
alias show=rg

alias utc="sudo systemsetup -settimezone GMT"
alias sf="sudo systemsetup -settimezone America/Los_Angeles"

# Setup for racer/rust
export RUST_SRC_PATH=~/rust/src

# Source integrations
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  export FZF_DEFAULT_OPTS="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:$base2,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "
}
_gen_fzf_default_opts

export FZF_DEFAULT_COMMAND='fd'
