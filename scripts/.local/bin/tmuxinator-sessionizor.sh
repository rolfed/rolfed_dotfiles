# ~/.local/bin
#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/repos ~/repos/corvette -mindepth 1 -maxdepth 1 -type d | fzf --layout=reverse --border --info=inline --margin=8,20 --padding=1)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_config_file="$selected/.tmuxinator.yml"
if [[ -f "$tmux_config_file" ]]; then
  cd $selected
  tmuxinator local
  cd -
else
  tmuxinator start project -n $selected_name workspace=$selected
fi

