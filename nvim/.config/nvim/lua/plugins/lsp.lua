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
                    "clangd",
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        -- lazy = false,
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
            lspconfig.html.setup({
                capabilities = capabilities
            })

            local angular_language_server_path = "~/n/lib/node_modules/@angular/language-server"
            local util = require('lspconfig.util')
            local root_dir = util.root_pattern('angular.json', 'project.json')
            local cmd = { "ngserver", "--stdio", "--tsProbeLocations", angular_language_server_path, "--ngProbeLocations",
                angular_language_server_path }
            lspconfig.angularls.setup({
                -- AngularLS requires that the language server version matches
                -- that of the project
                -- Install Angular major version of the project
                -- npm -g uninstall @angular/language-server
                -- npm -g install @angular/language-server@[the latest matching angular-version]
                cmd = cmd,
                root_dir = root_dir,
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = cmd
                end,
                capabilities = capabilities,
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
