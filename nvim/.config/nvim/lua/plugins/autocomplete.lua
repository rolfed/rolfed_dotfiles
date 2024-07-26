return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        },
    },
    {
        -- A completion engine plugin for neovim written in Lua.
        -- Completion sources are installed from external repositories and "sourced".
        'hrsh7th/nvim-cmp',
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind.nvim', -- icons for auto complete
            'windwp/nvim-autopairs'
        },
        config = function()
            -- Set up nvim-cmp.
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            local lspkind = require('lspkind')

            require("luasnip.loaders.from_vscode").lazy_load()

            -- Integrate nvim autopairs with cmp
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mappings = {
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }
            -- disable tab
            cmp_mappings['<Tab>'] = nil
            cmp_mappings['<S-Tab>'] = nil

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert(cmp_mappings),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 1 },                     -- lsp
                    { name = "buffer",   max_item_count = 5, group_index = 2 }, -- text within current buffer
                    { name = "path",     max_item_count = 3, group_index = 3 }, -- file system paths
                    { name = "luasnip",  max_item_count = 3, group_index = 5 }, -- snippets
                }),
                -- Enable pictogram icons for lsp/autocompletion
                formatting = {
                    expandable_indicator = true,
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        menu = {
                            nvim_lsp = "[LSP]",
                            buffer = "[Buffer]",
                            path = "[PATH]",
                            luasnip = "[LuaSnip]",
                        }
                    })
                },
                experimental = {
                    ghost_text = true,
                },

            })
        end,
    }
}
