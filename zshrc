export ZSH=$HOME/.oh-my-zsh
export EDITOR=/usr/local/bin/vim
ZSH_THEME="ys"

plugins=(vi-mode git python pip brew bundler rake ruby rails zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1

export PATH="$HOME/.multirust/toolchains/nightly/cargo/bin:$HOME/arcinst/arcanist/bin:$HOME/cargo-clippy/target/release:$HOME/.fzf/bin:$HOME/.rvm/bin:$HOME/Library/Haskell/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

alias nv=nvim
alias nvi=nvim
alias vim=nvim
alias devbox="ssh -A devbox.lo"
alias show=ag
export RUST_SRC_PATH=~/rust/src

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.1.5
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/scribd.zsh ] && source ~/scribd.zsh

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export XDG_CONFIG_HOME=$HOME
export EDITOR=nvim
