return {
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    {
        'hrsh7th/cmp-path'
    },
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
        config = function()
            -- Set up nvim-cmp.
            local cmp = require('cmp')
            require("luasnip.loaders.from_vscode").lazy_load()

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
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert(cmp_mappings),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })
        end,
    }
}
