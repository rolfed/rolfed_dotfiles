-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<C-H>', require('smart-splits').resize_left, { desc = "Resize window left" })
vim.keymap.set('n', '<C-J>', require('smart-splits').resize_down, { desc = "Resize window down" })
vim.keymap.set('n', '<C-K>', require('smart-splits').resize_up, { desc = "Resize window up" })
vim.keymap.set('n', '<C-L>', require('smart-splits').resize_right, { desc = "Resize window right" })
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left, { desc = "Move to left window" })
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down, { desc = "Move to window below" })
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up, { desc = "Move to window above" })
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right, { desc = "Move to right window" })
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous, { desc = "Move to previous window" })
-- swapping buffers between windows
vim.keymap.set('n', '<C-b>h', require('smart-splits').swap_buf_left, { desc = "Swap buffer left" })
vim.keymap.set('n', '<C-b>j', require('smart-splits').swap_buf_down, { desc = "Swap buffer down" })
vim.keymap.set('n', '<C-b>k', require('smart-splits').swap_buf_up, { desc = "Swap buffer up" })
vim.keymap.set('n', '<C-b>l', require('smart-splits').swap_buf_right, { desc = "Swap buffer right" })
