local builtin = require('telescope.builtin')
-- project files
vim.keymap.set('n', '<leader>FF', builtin.find_files, {})

-- git specific files
vim.keymap.set('n', '<leader>fF', builtin.git_files, {})

-- find buffers
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

-- grep search telecscopes
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- search help tags
vim.keymap.set('n', '<C-h>', builtin.help_tags, {})

vim.api.nvim_create_user_command('OpenGitFilesInVSplit', function()
    vim.cmd('vsplit')                        -- Split the view vertically
    require('telescope.builtin').git_files() -- Open Telescope to search Git files
end, { nargs = 0 })

vim.api.nvim_set_keymap('n', '<leader>fs', ':OpenGitFilesInVSplit<CR>', { noremap = true, silent = true })
