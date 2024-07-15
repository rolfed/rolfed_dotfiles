local builtin = require('telescope.builtin')
-- project files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- git specific files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- grep search telecscope
vim.keymap.set("n", "<leader>ps", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
-- grep search-- grep search-- grep search-- grep search-- grep search-- grep search-- grep search-- grep search
--vim.keymap.set('n', '<leader>ps', function()
--    builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end)

-- search help tags
vim.keymap.set('n', '<C-h>', builtin.help_tags, {})

vim.api.nvim_create_user_command('OpenGitFilesInVSplit', function()
  vim.cmd('vsplit') -- Split the view vertically
  require('telescope.builtin').git_files() -- Open Telescope to search Git files
end, { nargs = 0 })
vim.api.nvim_set_keymap('n', '<C-w>f', ':OpenGitFilesInVSplit<CR>', { noremap = true, silent = true })
