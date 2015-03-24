export ZSH=$HOME/.oh-my-zsh
export EDITOR=/usr/local/bin/vim
ZSH_THEME="ys"

plugins=(git python pip brew bundler rake ruby rails zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/Library/Haskell/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin"
