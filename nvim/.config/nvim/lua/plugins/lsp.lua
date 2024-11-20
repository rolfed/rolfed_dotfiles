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
                    "ts_ls",
                    "clangd",
                    "bashls",
                    "denols",
                    "spellcheck",
                    "black"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost" },
        config = function()
            -- Integrate LSP with autocomplete
            local capabilities = require('cmp_nvim_lsp')
                .default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local lspconfig = require("lspconfig")

            local servers = {
                lua_ls = {},
                ts_ls = {
                    on_attach = on_attach,
                    root_dir = lspconfig.util.root_pattern("package.json"),
                    single_file_support = false,
                },
                denols = {
                    on_attach = on_attach,
                    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
                    single_file_support = false,
                },
                black = {},
                html = {},
                -- eslint_d = {},
                clangd = {},
                gopls = {},
                java_language_server = {},
                gradle_ls = {},
                nixd = {
                    cmd = { "nixd" },
                    settings = {
                        nixd = {
                            nixpkgs = {
                                expr = "import <nixpkgs> { }"
                            },
                            formatting = {
                                command = { "alejandra" }, -- or nixfmt or nixpkg-fmt
                            }
                        }
                    }
                }
            }

            for server, opts in pairs(servers) do
                opts.capabilities = capabilities
                lspconfig[server].setup(opts)
            end
        end
    }
}
