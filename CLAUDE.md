# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles ("Dotfiles 2.0") for a macOS development environment. Configs for ZSH, Tmux, Emacs, Vim/Neovim, Yabai (tiling WM), SKHD (keyboard daemon), and Alacritty.

## Validation

```bash
# Check shell scripts for errors
shellcheck zsh_setup/config/*.sh

# Validate Emacs config loads
emacs --batch -l emacs/init.el
```

## Architecture

### ZSH Modular Config System

The main entry point is `zsh_setup/.zshrc`, which sources `zsh_setup/.my_zsh_setup.sh`. That script sources all numbered config files in `zsh_setup/config/` (`01_terminal.sh` through `13_fzf_config.sh`). Each module handles a specific domain (environment, networking, tools, languages, etc.). To add new config, create a new numbered file in `zsh_setup/config/` and add a source line in `.my_zsh_setup.sh`.

Key dependencies: Oh-My-ZSH, Powerlevel10k prompt, FZF with fd.

### Emacs Literate Config

`emacs/init.el` bootstraps straight.el and loads `emacs/config.org`, which contains the full configuration in Org-mode code blocks. Edit `config.org` for Emacs changes, not `init.el`.

### Theming

Catppuccin is used consistently across Tmux, Emacs, and the tmux-sessionizer script. Maintain this consistency when modifying theme-related config.

### Vim Keybindings Everywhere

Vim-style bindings are configured in ZSH (vi-mode), Tmux (vi-mode copy), Emacs (Evil mode), SKHD (cmd+hjkl navigation), and IdeaVim (`.ideavimrc`).

### Tmux Session Management

Custom scripts in `bin/.local/scritps/` provide FZF-based tmux session creation and switching. `tmux-sessionizer.sh` searches `~/projects/*`, `~/forks`, `~/study` for project directories and auto-creates tmux sessions with nvim and shell windows.

Tmux uses TPM (Tmux Plugin Manager) with plugins for vim-tmux-navigator, resurrect, continuum, and catppuccin theme.

### macOS Window Management

Yabai (BSP tiling WM) and SKHD (hotkey daemon) work together. `yabai/.yabairc` defines layout/gaps/opacity. `skhd/skhdrc` defines keyboard shortcuts using cmd+hjkl for window focus and shift+cmd+hjkl for window swapping.

## Key Bindings Reference

- **Tmux prefix**: `Ctrl-a`
- **SKHD window focus**: `cmd+hjkl`
- **Vim escape remap**: `kj` (in vim_setup and ideavimrc)
