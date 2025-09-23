# Git Workflow for Dotfiles

## Core Principle: Fast Iteration + Easy Recovery

**Philosophy**: Make changes quickly and safely. Git is your safety net.

## Standard Process

### For Any Change
1. **Make the change** - Edit files directly
2. **Quick validation** - Run syntax check if applicable
3. **Commit immediately** - Don't batch unrelated changes
4. **If broken** - Use git to rollback instantly

### Validation Commands
```bash
# Only test what's fast and meaningful
case "$file" in
    *.lua) lua -c "dofile('$file')" ;;
    *.sh) shellcheck "$file" ;;
    *) echo "No validation needed" ;;
esac
```

## Branch Strategy

### Main Branch
- **Always deployable** - Should work on your machine
- **Small commits** - Easy to identify and rollback issues
- **Direct commits OK** - For simple, low-risk changes

### Feature Branches
Use only for:
- **Major tool additions** (new language support, significant plugins)
- **Experimental changes** (testing new workflows)
- **Breaking changes** (major config restructures)

### Branch Naming
```
feat/add-rust-support
fix/jdtls-lombok-jar
experiment/wezterm-tabs
```

## Commit Format

### Standard Commits
```
[type](scope): brief description

Details if needed.

Manual test: [what user should verify]
Rollback: git checkout HEAD~1 -- [file]

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>
```

### Types
- `feat`: New functionality
- `fix`: Bug fixes
- `config`: Configuration changes
- `docs`: Documentation updates
- `refactor`: Code reorganization

### Examples
```
feat(nvim): add java debugging support

- Configure JDTLS with Mason integration
- Add keybindings in after/plugin/jdtls.lua
- Download lombok.jar dependency

Manual test: open Java file, check :LspInfo
Rollback: git checkout HEAD~1 -- nvim/.config/nvim/ftplugin/java.lua
```

```
fix(lsp): add gradle_ls to ensure_installed

Manual test: restart nvim, check gradle files have LSP
Rollback: git checkout HEAD~1 -- nvim/.config/nvim/lua/plugins/lsp.lua
```

## High-Risk Changes (Create Backup Branch)

### Before Major Changes
```bash
# Create backup branch
git checkout -b backup/before-major-change
git checkout main

# Make changes...
# If disaster: git checkout backup/before-major-change
```

### High-Risk Files
- `nvim/.config/nvim/init.lua` - Core Neovim config
- `zsh/.zshrc` - Shell configuration
- `nix/flake.nix` - System packages
- `tmux/.tmux.conf` - Terminal multiplexer

## Recovery Procedures

### Rollback Last Change
```bash
# Specific file
git checkout HEAD~1 -- [file]

# Entire commit
git reset --hard HEAD~1

# See what changed
git show HEAD
```

### Emergency Recovery
```bash
# Nuclear option - restore working state
git reset --hard origin/main

# Or go back N commits
git reset --hard HEAD~3
```

## Claude-Specific Guidelines

### Before Making Changes
1. **Read target file** to understand current state
2. **Use minimal changes** - Don't rewrite unnecessarily
3. **Test syntax** for scripted files only
4. **Commit immediately** after each logical change

### Commit Requirements
- **Always include** manual testing instructions
- **Always include** specific rollback command
- **Be specific** about what changed and why
- **One logical change** per commit

### What Claude Should NOT Do
- ❌ Batch multiple unrelated changes
- ❌ Create complex testing frameworks
- ❌ Optimize prematurely
- ❌ Make changes without understanding current state

### What Claude SHOULD Do
- ✅ Make minimal, targeted changes
- ✅ Provide clear rollback instructions
- ✅ Document what needs manual testing
- ✅ Commit each change separately

## Testing Philosophy

### What We Test
- **Syntax errors** - Fast and catches real issues
- **File existence** - Prevent broken references
- **Command availability** - Basic dependency checking

### What We Don't Test
- **Runtime behavior** - User will catch immediately
- **Integration testing** - Too complex for the value
- **Performance** - Not a concern for personal configs

### Manual Testing Instructions
Always include in commits:
- **What to test**: "Open Java file, check LSP status"
- **How to verify**: "Run :LspInfo, should show jdtls running"
- **Expected behavior**: "Syntax highlighting and completion should work"

## Workflow Examples

### Simple Config Change
```bash
# Edit file
vim nvim/.config/nvim/lua/plugins/new-plugin.lua

# Test syntax
lua -c "dofile('nvim/.config/nvim/lua/plugins/new-plugin.lua')"

# Commit
git add . && git commit -m "feat(nvim): add new plugin

Manual test: restart nvim, check plugin loads
Rollback: git checkout HEAD~1 -- nvim/.config/nvim/lua/plugins/new-plugin.lua"
```

### System Package Addition
```bash
# Edit nix config
vim nix/flake.nix

# Apply changes
darwin-rebuild switch --flake nix

# Commit
git add . && git commit -m "feat(nix): add new development tool

Manual test: check tool is available in PATH
Rollback: git checkout HEAD~1 -- nix/flake.nix && darwin-rebuild switch --flake nix"
```

This workflow optimizes for **developer velocity** while maintaining **safety through git**. Simple, predictable, and fast.