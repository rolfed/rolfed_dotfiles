# https://github.com/joshmedeski/sesh
function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

# Register the function with Zsh Line Editor (ZLE)
zle -N sesh-sessions

# Bind Ctrl+F to the sesh-sessions function in all relevant keymaps
bindkey -M emacs '^F' sesh-sessions
bindkey -M vicmd '^F' sesh-sessions
bindkey -M viins '^F' sesh-sessions
