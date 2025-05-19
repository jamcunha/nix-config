vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2 -- spaces for tabs
vim.opt.shiftwidth = 0 -- spaces for indent (0 -> follow tabstop)
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.backspace = 'indent,eol,start'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.incsearch = true
vim.opt.inccommand = 'split' -- preview substitutions

vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5
vim.opt.wrap = false
vim.opt.encoding = 'utf-8'

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'

vim.opt.splitright = true
vim.opt.splitbelow = true
