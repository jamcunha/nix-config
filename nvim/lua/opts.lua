vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.lazyredraw = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true	-- Convert tab to spaces
vim.opt.shiftwidth = 4		-- Number of spaces of the indentation
vim.opt.tabstop = 4			-- Number of spaces of the indentation
vim.opt.smarttab = true		-- Tab with the number of spaces equal to tabstop

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Disable swap files
vim.opt.swapfile = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 5
vim.opt.wrap = false
vim.opt.encoding = "utf-8"
