Backup for my dotfiles.

Feel free to steal + adapt, the vast majority of my config has been stolen
from helpful people from around the web. (.tmux.conf is specifically
from Square's maximum-awesome config, altered for legibility with vim-gotham)

* Run ```make install``` to install all of the dotfiles into your home directory.
* Run ```make``` without a target to see the individual dotfile target options.

Fair warning: The installation will silently overwrite your existing dotfiles.

#### VIM setup

Run ```:PluginInstall``` in VIM to fetch and install the plugins.
&lt;Leader&gt; is bound to the spacebar, which may not be immediately evident from
glancing at the vimrc.
