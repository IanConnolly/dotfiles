export ZSH=$HOME/.oh-my-zsh
export EDITOR=/usr/local/bin/vim
ZSH_THEME="ys"

plugins=(vi-mode git python pip brew bundler rake ruby rails zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export KEYTIMEOUT=1

export PATH="$HOME/arcinst/arcanist/bin:$HOME/.rvm/bin:$HOME/Library/Haskell/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

alias nv=nvim
alias nvi=nvim
alias devbox="ssh -A devbox.lo"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.1.5
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
