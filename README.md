# Set up

Clone the repository to `~/.config/nvim`
```bash
git clone https://github.com/hgranthorner/nvim ~/.config/nvim
```

Run
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
to install Plug.

Run Neovim and :PlugInstall. Restart Neovim.
