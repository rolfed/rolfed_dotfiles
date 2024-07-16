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
                    "java_language_server",
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

            -- FE Web Dev 
            lspconfig.tsserver.setup({})
            lspconfig.angularls.setup({})
            lspconfig.html.setup({})

            -- C and C++
            lspconfig.clangd.setup({})

            -- Go
            lspconfig.gopls.setup({})

            -- Java
            lspconfig.java_language_server.setup({})
            lspconfig.gradle_ls.setup({})

        end
    }
}
