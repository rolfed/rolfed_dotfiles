local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon"})
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "View all files in harpoon"})

-- Jump to next
vim.keymap.set("n", "<C-N>", function() ui.nav_next() end, { desc = "Go to next file in harpoon"})
--- Jump to prevt
vim.keymap.set("n", "<C-n>", function() ui.nav_prev() end, { desc = "Go to prev file in harpoon"})
