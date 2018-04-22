[ -z "$PS1" ] && return

source /usr/local/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
PROMPT_COMMAND='__git_ps1 "\w" " \\\$ "'
# PS1='[\w $(__git_ps1 " (%s)")] \$ '

shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist

export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
HISTTIMEFORMAT='%F %T '
HISTCONTROL="erasedups:ignoreboth"
HISTSIZE=500000
HISTFILESIZE=100000

export XDG_CONFIG_HOME=$HOME
export EDITOR=vim

alias ls='ls -lFG'

# Setup for racer/rust
export RUST_SRC_PATH=~/rust/src

# Source integrations
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

export PATH=/Users/ianconnolly/.local/bin/luna-studio:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ianconnolly/google-cloud-sdk/path.bash.inc' ]; then source '/Users/ianconnolly/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ianconnolly/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/ianconnolly/google-cloud-sdk/completion.bash.inc'; fi
