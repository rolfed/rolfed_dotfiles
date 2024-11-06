--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('update-right-status', function(win)
    win:set_right_status(win:active_workspace())
end)


local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end


config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
    { family = "JetBrainsMono Nerd Font", scale = 1.2, weight = "Medium", },
    { family = "Source Code Pro",         scale = 1.0, },
})
config.window_background_opacity = 0.95
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.use_dead_keys = false
config.scrollback_lines = 3000
config.default_workspace = "main"
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true

-- Dim inactive panes
config.inactive_pane_hsb = {
    saturation = 0,
    brightness = 0.25,
}

-- Fzf search window
local function fzf_search(win, pane)
    local workspaces = mux.get_workspace_names()
    --win:perform_action(
    --  act.SplitPane {
    --    direction = 'Down',
    --    -- command = { args = { 'bash', '-c', 'cd ~/repos && nvim $(find . -type d | fzf)' } },
    --    size = { Percent = 50 },
    --  },
    --  pane
    --)
end

-- Work on project
local function edit_project(win, pane)
    win:perform_action(
        act.SpawnCommandInNewTab {
            -- args = { 'bash', '-c', [[
            --   dir=$(find ~/repos -type d | fzf)
            --   if [ -n "$dir" ]; then
            --     dir_name=$(basename "$dir")
            --     wezterm cli set-tab-title --title $dir_name
            --     wezterm cli split-pane --top --percent 70 -- bash -c "cd '$dir' && nvim ."
            --     wezterm cli split-pane --bottom -- bash -c "cd '$dir' && zsh"
            --   fi
            -- ]] }
        },
        pane
    )
end

local function create_workspace(win, pane, line)
    -- line will be 'nil' if escape without entering anything
    -- an empty string enter was pressed
    -- Or the actual line of text they wrote
    if line then
        win:perform_action(
            act.SwitchToWorkspace {
                name = line,
            },
            pane
        )
    end
end


config.disable_default_key_bindings = true
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
    -- Paste
    { key = "v",     mods = "CMD",    action = act.PasteFrom 'Clipboard' },
    { key = "V",     mods = "CMD",    action = act.PasteFrom 'PrimarySelection' },

    -- Activate Copy Mode or vim mode
    { key = "Enter", mods = "LEADER", action = act.ActivateCopyMode },

    -- Pane Navigation
    -- handled by smart-splits

    -- Rotate Panes
    { key = "R", mods = "LEADER", action = act.RotatePanes "Clockwise", },
    { key = "0",     mods = "LEADER", action = act.PaneSelect, },

    -- Tab Management
    { key = "t",     mods = "CTRL",   action = act.SpawnTab 'CurrentPaneDomain' },
    { key = "X",     mods = "CTRL",   action = act.CloseCurrentTab { confirm = false } },
    { key = "M",     mods = "CTRL",   action = act.MoveTabRelative(-1) },
    { key = "<",     mods = "CTRL",   action = act.MoveTabRelative(1) },

    -- Tab Navigation
    { key = "m",     mods = "CTRL",   action = act.ActivateTabRelative(-1) },
    { key = ",",     mods = "CTRL",   action = act.ActivateTabRelative(1) },

    -- Window Management
    { key = "f",     mods = "LEADER", action = act.ToggleFullScreen },
    { key = "z",     mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "-",     mods = "LEADER", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = "|",     mods = "LEADER", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = "x",     mods = "LEADER", action = act.CloseCurrentPane { confirm = false } },

    -- Workspace Management
    -- { key = "J",     mods = "CTRL",   action = act.SwitchWorkspaceRelative(1) },
    -- { key = "K",     mods = "CTRL",   action = act.SwitchWorkspaceRelative(-1) },
    {
        key = "W",
        mods = "CTRL",
        action = act.PromptInputLine {
            description = wezterm.format {
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = "Enter name for workspace: " },
            },
            action = wezterm.action_callback(create_workspace),
        }
    },

    -- Fzf Integration
    { key = "/", mods = "CTRL", action = wezterm.action.EmitEvent("switch-workspace") },
    -- { key = "e", mods = "CTRL", action = wezterm.action_callback(edit_project) },
}

return config
