local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Jump to next
vim.keymap.set("n", "<C-m>", function() ui.nav_next() end)
--- Jump to prevt
vim.keymap.set("n", "<C-n>", function() ui.nav_prev() end)
