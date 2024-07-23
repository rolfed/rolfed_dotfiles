# ~/.local/bin
#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(tmuxinator list | fzf --layout=reverse --border --info=inline --margin=8,20 --padding=1 )
fi

if [[ -z $selected ]]; then
    exit 0
fi

# selected_name=$(basename "$selected" | tr . _)
# tmux_config_file="$selected/.tmuxinator.yml"
# if [[ -f "$tmux_config_file" ]]; then
#   cd $selected
#   tmuxinator local
#   cd -
# else
tmuxinator start $selected
# fi

