set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'

    # If last comand was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1="$Green$Checkmark "
    else
        PS1="$Red$FancyX "
    fi

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        PS1+="$Red\\h "
    else
        PS1+="$Green\\u@\\h "
    fi

    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    PS1+="$Blue\\w \\\$$Reset "
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

