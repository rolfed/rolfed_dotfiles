return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "BufEnter" },
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            auto_install = true, -- auto install languae for treesitter
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
