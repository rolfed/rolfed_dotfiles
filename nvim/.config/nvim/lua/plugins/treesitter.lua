return {
    -- List of available languages
    -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
    "nvim-treesitter/nvim-treesitter",
    build = ':TSUpdate',
    event = { "BufEnter" },
    config = function()
        local config = require('nvim-treesitter.configs')
        config.setup({
            auto_install = true, -- auto install languae for treesitter
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
