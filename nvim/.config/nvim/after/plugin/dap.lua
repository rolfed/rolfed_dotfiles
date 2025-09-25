local dap = require("dap")
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = "Dap toggle breakpoint" })
vim.keymap.set('n', '<leader>dr', dap.continue, { desc = "Debug: Continue/Run" })
