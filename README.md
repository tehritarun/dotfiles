# dotfiles

Below are required programms
- git
- tmux
- nvim
- starship
- kitty
- alacritty

```bash
sudo pacman -S alacritty kitty git starship tmux nvim
```

Optional Terminal tools
- tree
- lazygit
- fzf

```bash
sudo pacman -S tree fzf lazygit
```

To copy update configuration file run below code. it will backup your existing configuration files.

```bash
git clone https://github.com/tehritarun/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash linkFiles.sh
```

for nvim config, backup your existing config and run following code.

```bash
git clone https://github.com/tehritarun/nvim_Config.git ~/.config/nvim
```
