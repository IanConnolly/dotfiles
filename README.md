Backup for my dotfiles.

Feel free to steal + adapt, the vast majority of my config has been stolen
from helpful people from around the web.

* Run ```make install``` to install all of the dotfiles into your home directory.
* Run ```make``` without a target to see the individual dotfile target options.

Fair warning: The installation will silently overwrite your existing dotfiles.

### Requirements

* OSX (The vimrc hasn't been properly system gated yet)
* Homebrew
* Homebrew compiled Neovim
* 24-bit colour support in terminal (including tmux)
* zsh + oh-my-zsh
* Git
* Tmux
* Python + Pip, Ruby, Node + npm

The vim configuration should work fine in regular, non-neovim Vim, but a bunch of the colours
in the statusline + the gutter are set manually and will need to be fixed up.


### Troubleshooting

If Ruby omnifunc is segfaulting vim (ie. when you hit '.' after an object and
would expect a method list to pop up), then vim was linked to an ```rvm```
ruby. Re-install vim with:

```
rvm system do brew install vim
```

