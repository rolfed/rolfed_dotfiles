vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" });

-- Move visually selected block up or down
vim.keymap.set("v", "U", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "D", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- bring bottom line up while keeping cursor in begining
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Move page and keep focus in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (center)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (center)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search (center)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search (center)" })

-- Copy and keep item in buffer
vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste (keep register)" })
vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete (keep register)" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete (keep register)" })

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy line to clipboard" })

-- Prevent accidental exiting
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex mode" })

-- run tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })

-- Format file
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Format file" })

-- quick fix
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })
vim.keymap.set("n", "<leader>K", "<cmd>lnext<CR>zz", { desc = "Next location" })
vim.keymap.set("n", "<leader>J", "<cmd>lprev<CR>zz", { desc = "Previous location" })

-- find and replace in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search & replace word" })


-- make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Need to configure
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain animation" });

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })

-- MdEval
vim.keymap.set('n', '<leader>c', function() require 'mdeval'.eval_code_block() end, { desc = "Eval markdown code block" })

-- Zen Mode
vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })
