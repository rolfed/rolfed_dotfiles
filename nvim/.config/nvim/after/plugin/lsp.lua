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

        -- Go to References
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        -- Go To Declaraion
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

        -- Go To Implementation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        -- Buffer View
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        -- View Signigure
        vim.keymap.set('n', 'gk>', vim.lsp.buf.signature_help, opts)

        -- Refactor
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

        -- Code Action
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

        -- Symbol
        -- vim.keymap.set('n', '<leader>lr', vim.lsp.buf.workspace_symbol(), opts)
    end,
})
