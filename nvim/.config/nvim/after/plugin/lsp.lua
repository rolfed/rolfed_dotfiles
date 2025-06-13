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
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = "Go To Definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts, { desc = "Go To Decleration" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = "Go To Implementation" })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = "View Signiture in hover" })
    vim.keymap.set('n', 'gk>', vim.lsp.buf.signature_help, opts, { desc = "View signiture" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts, { desc = "Refactor" })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set("n", "gr", builtin.lsp_references, {
      noremap = true,
      silent = true,
      desc = "Telescope: Search all references"
    })
  end,
})
