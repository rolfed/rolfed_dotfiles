return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = { "BufEnter" },
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            auto_install = true, -- auto install languae for treesitter
            ensure_installed = {
                "html",
                "lua",
                "markdown",
                "markdown_inline",
                "typescript",
                "css",
                "c",
                "http",
                "java"
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
