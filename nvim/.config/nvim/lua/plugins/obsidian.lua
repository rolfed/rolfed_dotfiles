return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "Work",
                path = "~/Documents/Obsidian/Work",
            },
            {
                name = "Personal",
                path = "~/Documents/Obsidian/Personal",
            },
        },

        -- Daily notes configuration
        daily_notes = {
            folder = "dailies",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            default_tags = { "daily-notes" },
            template = nil
        },

        -- Completion of wiki links, local markdown links, and tags
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        -- Note templates
        templates = {
            subdir = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
        },

        -- Note ID generation
        note_id_func = function(title)
            -- Create note IDs from title or timestamp
            if title ~= nil then
                return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                return tostring(os.time())
            end
        end,

        -- How to follow links
        follow_url_func = function(url)
            vim.fn.jobstart({"open", url})  -- Mac OS
        end,

        -- Image handling
        attachments = {
            img_folder = "assets/imgs",
        },

        -- UI configuration
        ui = {
            enable = true,
            update_debounce = 200,
            checkboxes = {
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
                [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
            },
            bullets = { char = "•", hl_group = "ObsidianBullet" },
        },

        -- Mappings (buffer-local for markdown files)
        mappings = {
            -- Toggle check-boxes
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true, desc = "Toggle checkbox" },
            },
            -- Smart action (follow link or toggle checkbox)
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true, desc = "Smart action" },
            },
        },
    },
}
