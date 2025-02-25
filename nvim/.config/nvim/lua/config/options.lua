vim.opt.guicursor = ""

-- Relative line numbers
vim.opt.nu = true
-- vim.opt.rnu = true
-- vim.o.statuscolumn = "%s %l %r   "
--

vim.opt.spell = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Long lived undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .."/.vim/undodir"
vim.opt.undofile = true

-- Incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- Keep scrolling focused
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = ","

vim.opt.foldlevelstart = 99

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Required by obsidian, for more info visit
-- https://github.com/epwalsh/obsidian.nvim#concealing-characters
vim.opt.conceallevel = 1

-- Disable new line with comment
vim.opt.formatoptions:remove { "c", "r", "o" }


