#   -----------------------------
#   TERMINAL CONFIG
#   -----------------------------
alias cp='cp -iv'                               # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ld='eza -lD'
alias lf='eza -lF --color=always | grep -v /' # lists only directories (no files)
alias lh='eza -dl .* --group-directories-first' # lists only files (no directories)
alias ll='eza -al --group-directories-first' # lists everything with directories first 
alias ls='eza -alF --color=always --sort=size | grep -v /' # lists only files sorted by size
alias lt='eza -al --sort=modified' # lists everything sorted by time updated
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd () { z "$@"; ll; }               # Always list directory contents upon 'cd'
alias edit='nvim'                           # edit:         Opens any file in vim editor
alias vim='nvim'			    			# vim	    	Opens nvim
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="z ~"                               # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -a'                       # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias mux='tmuxinator'                      # Tmuxinator alias
alias npml="npm ls -g --depth=0 --link=true" # List all symbolic links for npm packages
alias cb="git rev-parse --abbrev-ref HEAD" # cb:            Get current branch name
alias gcb="git branch --merged | egrep -v '(^\*|main|master)' | xargs git branch -d"
alias cat="bat"                             # Use bat instead of cat

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
mans () {
    man $1 | grep -iC2 --color=always $2 | less
}

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   Vim terminal binding
#   ------------------------------------------------------------
set -o vi
