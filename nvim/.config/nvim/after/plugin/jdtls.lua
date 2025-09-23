-- JDTLS specific keybindings and commands
-- This file is loaded after plugins are initialized

local function jdtls_keymaps()
  local jdtls = require('jdtls')
  local opts = { buffer = true, silent = true }

  -- Code actions
  vim.keymap.set('n', '<leader>co', jdtls.organize_imports,
    vim.tbl_extend('force', opts, { desc = 'Organize Imports' }))

  vim.keymap.set('n', '<leader>crv', jdtls.extract_variable,
    vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))

  vim.keymap.set('v', '<leader>crv', function() jdtls.extract_variable(true) end,
    vim.tbl_extend('force', opts, { desc = 'Extract Variable' }))

  vim.keymap.set('n', '<leader>crc', jdtls.extract_constant,
    vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))

  vim.keymap.set('v', '<leader>crc', function() jdtls.extract_constant(true) end,
    vim.tbl_extend('force', opts, { desc = 'Extract Constant' }))

  vim.keymap.set('v', '<leader>crm', function() jdtls.extract_method(true) end,
    vim.tbl_extend('force', opts, { desc = 'Extract Method' }))

  -- Test runner
  vim.keymap.set('n', '<leader>tc', jdtls.test_class,
    vim.tbl_extend('force', opts, { desc = 'Test: Run Current Class' }))

  vim.keymap.set('n', '<leader>tm', jdtls.test_nearest_method,
    vim.tbl_extend('force', opts, { desc = 'Test: Run Current Method' }))

  vim.keymap.set('n', '<leader>tr', jdtls.test_class,
    vim.tbl_extend('force', opts, { desc = 'Test: Run Current Class' }))

  -- DAP integration
  vim.keymap.set('n', '<leader>dc', function() jdtls.test_class({ config_overrides = { type = 'java' } }) end,
    vim.tbl_extend('force', opts, { desc = 'Debug: Test Class' }))

  vim.keymap.set('n', '<leader>dm', function() jdtls.test_nearest_method({ config_overrides = { type = 'java' } }) end,
    vim.tbl_extend('force', opts, { desc = 'Debug: Test Method' }))
end

-- Set up autocommand to apply keymaps when jdtls attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('JdtlsKeymaps', { clear = true }),
  pattern = '*.java',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'jdtls' then
      jdtls_keymaps()
    end
  end,
})

-- User commands for JDTLS
vim.api.nvim_create_user_command('JdtCompile', function()
  require('jdtls').compile()
end, { desc = 'Compile Java project' })

vim.api.nvim_create_user_command('JdtUpdateProjectConfig', function()
  require('jdtls').update_project_config()
end, { desc = 'Update Java project configuration' })

vim.api.nvim_create_user_command('JdtJol', function()
  require('jdtls').jol()
end, { desc = 'Open JOL (Java Object Layout)' })

vim.api.nvim_create_user_command('JdtBytecode', function()
  require('jdtls').javap()
end, { desc = 'Open bytecode for current class' })

vim.api.nvim_create_user_command('JdtJshell', function()
  require('jdtls').jshell()
end, { desc = 'Open JShell' })