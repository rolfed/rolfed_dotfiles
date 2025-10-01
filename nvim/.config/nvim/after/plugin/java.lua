-- Java-specific keymaps (only active when JDTLS is attached)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local jdtls = require('jdtls')
    local opts = { buffer = true }

    -- Code actions
    vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { buffer = true, desc = "Organize imports" })
    vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { buffer = true, desc = "Extract variable" })
    vim.keymap.set('v', '<leader>jv', function() jdtls.extract_variable(true) end, { buffer = true, desc = "Extract variable" })
    vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { buffer = true, desc = "Extract constant" })
    vim.keymap.set('v', '<leader>jc', function() jdtls.extract_constant(true) end, { buffer = true, desc = "Extract constant" })
    vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end, { buffer = true, desc = "Extract method" })

    -- Test actions
    vim.keymap.set('n', '<leader>jtc', jdtls.test_class, { buffer = true, desc = "Test class" })
    vim.keymap.set('n', '<leader>jtn', jdtls.test_nearest_method, { buffer = true, desc = "Test nearest method" })

    -- DAP (debugging) keymaps
    vim.keymap.set('n', '<leader>jdc', function() require('jdtls').test_class({ config = { console = 'integratedTerminal' }}) end, { buffer = true, desc = "Debug class" })
    vim.keymap.set('n', '<leader>jdn', function() require('jdtls').test_nearest_method({ config = { console = 'integratedTerminal' }}) end, { buffer = true, desc = "Debug nearest method" })
  end
})
