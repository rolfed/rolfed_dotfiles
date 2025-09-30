-- Marks keymaps using marks.nvim
vim.keymap.set("n", "<leader>ma", ":lua require('marks').set_next()<CR>", { desc = "Add mark (next available)" })
vim.keymap.set("n", "<leader>md", ":lua require('marks').delete_line()<CR>", { desc = "Delete mark at current line" })
vim.keymap.set("n", "<leader>mn", ":lua require('marks').next()<CR>", { desc = "Go to next mark" })
vim.keymap.set("n", "<leader>mp", ":lua require('marks').prev()<CR>", { desc = "Go to previous mark" })
vim.keymap.set("n", "<leader>mt", ":lua require('marks').toggle()<CR>", { desc = "Toggle mark at current line" })

-- Telescope integration for finding marks
vim.keymap.set("n", "<leader>mf", function()
    require("telescope.builtin").marks({ only_sort_text = true, mark_type = "local" })
end, { desc = "Find marks (current file)" })

vim.keymap.set("n", "<leader>M", function()
    require("telescope.builtin").marks({ only_sort_text = true })
end, { desc = "Find marks (all files)" })