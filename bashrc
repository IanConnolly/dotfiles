parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

parse_git_dirty() {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]; then
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

export PATH="$HOME/arcinst/arcanist/bin:$HOME/.fzf/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Neovim setup
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export XDG_CONFIG_HOME=$HOME
export EDITOR=nvim

# Aliases
alias nv=nvim
alias nvi=nvim
alias vim=nvim
alias view="nvim +\"set readonly\""
alias devbox="ssh -A devbox.lo"
alias show=ag

# Setup for racer/rust
export RUST_SRC_PATH=~/rust/src

# Source integrations
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

