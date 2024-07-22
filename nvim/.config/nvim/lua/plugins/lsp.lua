return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                -- List of servers: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#configuration
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "angularls",
                    "clangd"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            -- Integrate LSP with autocomplete
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")

            -- LUA
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })

            -- FE Web Dev
            lspconfig.tsserver.setup({
                capabilities = capabilities
            })
            lspconfig.angularls.setup({
                capabilities = capabilities
            })
            lspconfig.html.setup({
                capabilities = capabilities
            })

            -- C and C++
            lspconfig.clangd.setup({
                capabilities = capabilities
            })

            -- Go
            lspconfig.gopls.setup({
                capabilities = capabilities
            })

            -- Java
            lspconfig.java_language_server.setup({
                capabilities = capabilities
            })
            lspconfig.gradle_ls.setup({
                capabilities = capabilities
            })
        end
    }
}
