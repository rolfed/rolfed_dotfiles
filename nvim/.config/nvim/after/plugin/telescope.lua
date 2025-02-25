local builtin = require('telescope.builtin')
-- project files
vim.keymap.set('n', '<leader>fF', builtin.find_files, { desc = "Find files" })

-- git specific files
vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Fine git tracked files"})

-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers"})

-- grep search telecscopes
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep search"})

-- search help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Search help tags"})

-- Search git files and split screen
vim.api.nvim_create_user_command('OpenGitFilesInVSplit', function()
  vim.cmd('vsplit')                        -- Split the view vertically
  require('telescope.builtin').git_files() -- Open Telescope to search Git files
end, { nargs = 0 })

vim.api.nvim_set_keymap('n', '<leader>fs', ':OpenGitFilesInVSplit<CR>', { noremap = true, silent = true, desc = "Find files and split screen" })
