return {
    'folke/zen-mode.nvim',
    config = function()
        require("zen-mode").setup({
            window = {
                backdrop = 1,
                width = 140,  -- width of the Zen window
                height = 0.8,   -- height of the Zen window
                options = {
                    signcolumn = "no", -- disable signcolumn
                    number = true, -- disable number column
                    relativenumber = false, -- disable relative numbers
                    cursorline = true, -- disable cursorline
                    -- cursorcolumn = false, -- disable cursor column
                    -- foldcolumn = "0", -- disable fold column
                    -- list = false, -- disable whitespace characters
                },
            },
            plugins = {
                -- disable some global vim options (vim.o...)
                options = {
                    enabled = true,
                    ruler = false, -- disables the ruler text in the cmd line area
                    showcmd = false, -- disables the command in the last line of the screen
                    -- you may turn on/off statusline in zen mode by setting 'laststatus'
                    -- statusline will be shown only if 'laststatus' == 3
                    laststatus = 0, -- turn off the statusline in zen mode
                },
                twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
                gitsigns = { enabled = true }, -- disables git signs
                tmux = { enabled = true }, -- disables the tmux statusline
                wezterm = {
                    enabled = true,
                    font = "+20", -- (10% increase per step)
                },
            },
        })
    end
}
