-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<C-H>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-J>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-K>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-L>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
-- swapping buffers between windows
vim.keymap.set('n', '<C-b>h', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<C-b>j', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<C-b>k', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<C-b>l', require('smart-splits').swap_buf_right)
