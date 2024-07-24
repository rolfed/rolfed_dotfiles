-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }

        -- Go to Definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

        -- Go To Declaraion
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        -- Go To Implementation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        -- Buffer View
        vim.keymap.set('n', 'gK', vim.lsp.buf.hover, opts)

        -- View Signigure
        vim.keymap.set('n', 'gk', vim.lsp.buf.signature_help, opts)

        -- Refactor
        vim.keymap.set('f', '<leader>rf', vim.lsp.buf.rename, opts)

        -- Code Action
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

        -- Symbol
        -- TODO how to pass in query
        -- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.workspace_symbol(), {})
    end,
})
