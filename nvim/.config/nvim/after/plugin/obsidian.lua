require("obsidian").setup({
    workspaces = {
        -- {
        --     name = "Work",
        --     path = "~/repos/vault/work"
        -- },
        {
            name = "Personal",
            path = "~/repos/vault/personal"
        }
    },
    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "notes/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
    },

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },

    -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
    -- way then set 'mappings = {}'.
    mappings = {
        -- Toggle check-boxes.
        ["<leader>ch"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        }
    },
})
