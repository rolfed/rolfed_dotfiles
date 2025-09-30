-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local builtin = require('telescope.builtin')

    -- Core navigation (g prefix for "goto")
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go to implementation" })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
    vim.keymap.set("n", "gr", builtin.lsp_references, {
      buffer = ev.buf,
      noremap = true,
      silent = true,
      desc = "Go to references"
    })

    -- Hover and documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })

    -- Code actions and refactoring
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action (range)" })
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })

    -- LSP workspace (leader + lw prefix)
    vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "Add workspace folder" })
    vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "Remove workspace folder" })
    vim.keymap.set('n', '<leader>lwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = ev.buf, desc = "List workspace folders" })

    -- LSP info and symbols (leader + l prefix)
    -- Note: <leader>li is defined globally in remap.lua so it's always available
    vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<CR>', { buffer = ev.buf, desc = "Restart LSP" })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { buffer = ev.buf, desc = "Document symbols" })
    vim.keymap.set('n', '<leader>lS', builtin.lsp_dynamic_workspace_symbols, { buffer = ev.buf, desc = "Workspace symbols" })

    -- Formatting
    vim.keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = ev.buf, desc = "Format buffer" })
    vim.keymap.set('v', '<leader>lf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = ev.buf, desc = "Format selection" })

    -- Inlay hints (Neovim 0.10+)
    if vim.lsp.inlay_hint then
      vim.keymap.set('n', '<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { buffer = ev.buf, desc = "Toggle inlay hints" })
    end
  end,
})

-- Diagnostic keymaps (available globally, not just when LSP is attached)
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float, { desc = "Show error details" })
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = "Next error" })
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = "Previous error" })
vim.keymap.set('n', '<leader>eq', vim.diagnostic.setloclist, { desc = "Local error list" })
vim.keymap.set('n', '<leader>eQ', vim.diagnostic.setqflist, { desc = "Global error list" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
