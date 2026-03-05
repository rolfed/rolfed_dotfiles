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
            'hrsh7th/cmp-spell',
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
            require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
            require("nvim-autopairs").setup()

            -- Snippet keymaps
            local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets"

            vim.keymap.set("n", "<leader>css", function()
              require("telescope.builtin").find_files({ cwd = snippet_path, prompt_title = "Snippet Files" })
            end, { desc = "Search snippets" })

            vim.keymap.set("n", "<leader>cse", function()
              local ft = vim.bo.filetype
              local file = snippet_path .. "/" .. ft .. ".lua"
              vim.cmd("edit " .. file)
            end, { desc = "Edit snippet file for current filetype" })

            vim.keymap.set("n", "<leader>csr", function()
              require("luasnip.loaders.from_lua").lazy_load({ paths = { snippet_path } })
              vim.notify("Snippets reloaded", vim.log.levels.INFO)
            end, { desc = "Reload snippets" })

            -- Snippet jump keymaps
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
              if luasnip.jumpable(1) then luasnip.jump(1) end
            end, { desc = "Snippet: jump to next placeholder" })

            vim.keymap.set({ "i", "s" }, "<C-h>", function()
              if luasnip.jumpable(-1) then luasnip.jump(-1) end
            end, { desc = "Snippet: jump to previous placeholder" })

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
                    { name = "luasnip",  max_item_count = 3, group_index = 1 }, -- snippets
                    { name = "buffer",   max_item_count = 5, group_index = 2 }, -- text within current buffer
                    { name = "path",     max_item_count = 3, group_index = 3 }, -- file system paths
                    { name = "spell",    max_item_count = 5, group_index = 4 }, -- spell suggestions
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
