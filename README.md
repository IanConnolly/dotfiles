Backup for my dotfiles.

Feel free to steal + adapt, the vast majority of my config has been stolen
from helpful people from around the web.

* Run ```make install``` to install all of the dotfiles into your home directory.
* Run ```make``` without a target to see the individual dotfile target options.

Fair warning: The installation will silently overwrite your existing dotfiles.

### Requirements

* OSX (The vimrc hasn't been properly system gated yet)
* Homebrew
* Homebrew compiled Vim
* zsh + oh-my-zsh
* Git
* Tmux
* Python + Pip, Ruby, Node + npm


### Troubleshooting

If Ruby omnifunc is segfaulting vim (ie. when you hit '.' after an object and
would expect a method list to pop up), then vim was linked to an ```rvm```
ruby. Re-install vim with:

```
rvm system do brew install vim
```

