return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                integrations = {
                    cmp = true,
                    harpoon = true,
                    gitsigns = true,
                    mason = true,
                    noice = true,
                    telescope = true,
                    treesitter = true,
                    treesitter_context = true,
                    symbols_outline = true,
                }
            })

            vim.cmd.colorscheme('catppuccin-macchiato')
        end
    },
}
