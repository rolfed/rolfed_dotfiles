# Rolfed Dotfiles
This repository contains configuration files (dotfiles) for GNU Stow, Wezterm, and Neovim, tailored to suit personal preferences and workflows.

## Technologies Used
- GNU Stow: For managing the symbolic links to your configuration files.
- Wezterm: A GPU-accelerated terminal emulator and multiplexer.
- Neovim (Nvim): An extensible text editor that improves on Vim.

## Setup
### Install Nix 
[install](https://nixos.org/download/#download-nix)

### Installation Instructions
To use these dotfiles on your system, follow these steps:

1. Clone the Repository:
```bash
git clone git@github.com:rolfed/rolfed_dotfiles.git ~/rolfed_dotfiles
```

2. Set Up GNU Stow:
GNU Stow will help you manage your dotfiles by creating symbolic links from your cloned repository to the appropriate locations in your home directory.

3. Run stow command to link configuration files
```bash
cd ~/rolfed_dotfiles
stow nvim wezterm tmux zsh scripts starship
```

4. Install Darwin Flake
```bash
darwin-rebuild switch --flake ~/rolfed-dotfilex/nix
```

5. Reload Configuration:
Restart or reload Wezterm and Neovim to apply the new configurations.

## Install Dependencies

### Tmux Plugin Manager
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```


