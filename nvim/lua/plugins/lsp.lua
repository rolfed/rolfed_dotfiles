return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- Available LSP Servers can be found at
                    -- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
                    "lua_ls",
                    "clangd",
                    "angularls",
                    "gradle_ls",
                    "html",
                    "tsserver",
                    "gopls",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- LUA
            lspconfig.lua_ls.setup({})

            -- Typescript
            lspconfig.tsserver.setup({})

        end
    }
}
