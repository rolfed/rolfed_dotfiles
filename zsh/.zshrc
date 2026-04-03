# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# --- Oh My Zsh plugins (MUST be set BEFORE sourcing oh-my-zsh.sh) ---
# Keep this list here and only here.
plugins=(git docker docker-compose)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# --- Safety: prevent virtualenvwrapper from being active even if something else tries ---
# This stops the "source venv/bin/activate" behavior.
unset -f workon 2>/dev/null
unset -f mkvirtualenv 2>/dev/null
unset -f rmvirtualenv 2>/dev/null
unset -f lsvirtualenv 2>/dev/null
unset -f cpvirtualenv 2>/dev/null
unset -f cdvirtualenv 2>/dev/null
unset -f cdsitepackages 2>/dev/null
unset -f lssitepackages 2>/dev/null
unset -f showvirtualenv 2>/dev/null
unset -f toggleglobalsitepackages 2>/dev/null
unset -f add2virtualenv 2>/dev/null

# Also ensure it isn't in the plugin list (in case a sourced file mutates $plugins)
plugins=(${plugins:#virtualenvwrapper})

# --- User configuration ---

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# Starship prompt
eval "$(starship init zsh)"

# Pyenv
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Load my Zsh setup (if present)
MY_ZSH_SETUP="$HOME/.my_zsh_setup.sh"
[[ -f "$MY_ZSH_SETUP" ]] && source "$MY_ZSH_SETUP"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Extra PATH
export PATH="/usr/local/sbin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# SDKMAN (must be near end)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# zoxide (must be last)
# _ZO_DOCTOR=0 suppresses the "configuration issue" warning in non-interactive
# shells (e.g. Claude Code) where __zoxide_hook isn't registered in chpwd_functions.
export _ZO_DOCTOR=0
eval "$(zoxide init zsh)"

