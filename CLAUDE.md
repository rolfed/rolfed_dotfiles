# Claude Dotfiles Guide

## Quick Commands

### Essential Operations
```bash
# Apply dotfiles
stow nvim wezterm tmux zsh scripts starship hammerspoon obsidian

# Update system packages
cd nix && darwin-rebuild switch --flake .

# Update plugins
nvim: :Lazy update
tmux: Prefix + U
```

### Validation
```bash
# Syntax checks
lua -c "dofile('nvim/.config/nvim/init.lua')"
shellcheck scripts/.local/bin/*.sh

# Rollback last change
git checkout HEAD~1 -- [file]
```

## High-Impact Files (Always backup before changing)
- `nvim/.config/nvim/init.lua` - Neovim entry point
- `zsh/.zshrc` - Shell configuration
- `nix/flake.nix` - System package management
- `tmux/.tmux.conf` - Terminal multiplexer

## Architecture Overview

### Core Technologies
- **Nix Darwin**: System packages + Homebrew integration
- **Stow**: Symlink management for dotfiles
- **Neovim**: 28+ plugins via Lazy.nvim
- **Tmux**: Session management with Sesh integration
- **WezTerm**: GPU-accelerated terminal with workspace management

### Key Integrations
- **Tmux ↔ Neovim**: Seamless navigation (vim-tmux-navigator)
- **FZF**: File/session finding throughout the system
- **Git**: Status in tmux bar, Neovim fugitive, starship prompt
- **Mason**: LSP/DAP/formatter management in Neovim

## Development Environment

### Supported Languages
- **Java**: Full JDTLS with debugging, testing, refactoring
- **TypeScript/JS**: VTSLS with import organization
- **Go**: LSP + DAP debugging
- **Python**: Pyenv integration + LSP
- **C/C++**: Clangd + LLDB debugging
- **Lua**: Full LSP for Neovim configuration
- **Bash/Shell**: LSP + linting

### Key Tools
- **LSP Servers**: bashls, clangd, gradle_ls, lua_ls, vtsls
- **Debugging**: nvim-dap (Go, Java, C/C++, Rust)
- **Testing**: Integrated test runners for Java
- **Formatters**: Language-specific via Mason

## File Locations

### Neovim Structure
```
nvim/.config/nvim/
├── init.lua                    # Entry point
├── lua/config/                 # Core configuration
├── lua/plugins/               # 28 plugin files
├── after/plugin/              # Post-load configurations
└── ftplugin/java.lua          # Java-specific JDTLS setup
```

### Shell Configuration
```
zsh/
├── .zshrc                     # Main shell config
└── zsh_config/               # 15 modular shell scripts
    ├── 01_terminal.sh → 14_sesh.sh
    ├── fzf.sh
    └── tmux-sessionizer.sh
```

### System Management
```
nix/
├── flake.nix                  # System packages + settings
└── flake.lock                 # Locked dependencies

scripts/.local/bin/            # Custom automation scripts
```

## Common Patterns

### Adding New Tool
1. **Read** existing similar configurations
2. **Add** to appropriate location (plugins/, nix/flake.nix, etc.)
3. **Test** syntax: `lua -c "dofile('file.lua')"`
4. **Apply**: `stow` or `darwin-rebuild switch --flake nix`
5. **Commit** with clear description

### Troubleshooting LSP Issues
1. **Check** `:LspInfo` in Neovim
2. **Verify** Mason installation: `:Mason`
3. **Review** logs: `~/.local/state/nvim/lsp.log`
4. **Reinstall** problematic server via Mason

### JDTLS Workspace Cache Issues
If JDTLS shows errors like "Can't read root project location" or "does not resolve to a ICompilationUnit":

```bash
# Clean JDTLS workspace cache
rm -rf ~/.local/share/nvim/jdtls-workspaces/[project-name]

# Remove corrupted Eclipse metadata from project
rm [project-path]/.project
rm [project-path]/.classpath
rm -rf [project-path]/.settings

# Restart Neovim - JDTLS will regenerate clean metadata
```

**Root Cause**: Corrupted Gradle Buildship configuration in Eclipse metadata files

### Session Management
1. **Create** sessions: `sesh connect [name]` or tmuxinator
2. **Switch** sessions: `Ctrl-a s` or FZF integration
3. **Save** layouts: tmux-resurrect (automatic)

## Recent Changes

### Java Development (Latest)
- **Migration**: nvim-java → nvim-jdtls for direct control
- **Features**: Full debugging, testing, refactoring support
- **Keybindings**: Organized in `after/plugin/jdtls.lua`
- **Dependencies**: lombok.jar automatically configured

### Known Issues & Solutions
- **JDTLS lombok.jar missing**: Download from projectlombok.org
- **Gradle language server permissions**: Add to Mason ensure_installed
- **HTML LSP CSS errors**: Known upstream issue, harmless

## Quick Recovery

### If Something Breaks
```bash
# Rollback specific file
git checkout HEAD~1 -- [broken-file]

# Rollback entire commit
git reset --hard HEAD~1

# Restore from backup (if created)
cp [file].backup [file]
```

### Emergency Fallback
```bash
# Minimal working environment
export PATH="/usr/bin:/bin"
/bin/bash --login
```

## Extension Points

### Adding New Language Support
1. **LSP**: Add server to `lua/plugins/lsp.lua` ensure_installed
2. **Syntax**: Treesitter handles most languages automatically
3. **Debugging**: Configure in `lua/plugins/dap.lua`
4. **Formatting**: Add to Mason ensure_installed

### Adding New Shell Tools
1. **Nix**: Add to `nix/flake.nix` systemPackages
2. **Shell integration**: Add module in `zsh/zsh_config/`
3. **Aliases**: Include in appropriate numbered module

This guide prioritizes **fast iteration** and **easy recovery** over complex validation. The goal is to make changes quickly and safely, with simple rollback when needed.