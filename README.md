# Rolfed Dotfiles
This repository contains configuration files (dotfiles) for GNU Stow, Wezterm, and Neovim, tailored to suit personal preferences and workflows.

## Technologies Used
- GNU Stow: For managing the symbolic links to your configuration files.
- Wezterm: A GPU-accelerated terminal emulator and multiplexer.
- Neovim (Nvim): An extensible text editor that improves on Vim.

## Install Dependencies

### Tmux
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### DAP
1. delve for Go 
```bash
brew install delve
```
2. lldb-cod
```bash
brew install llvm
```

## Installation Instructions
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
stow nvim wezterm tmux
```

4. Reload Configuration:
Restart or reload Wezterm and Neovim to apply the new configurations.
