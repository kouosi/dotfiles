-- Searching
vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.incsearch  = true
vim.opt.smartcase  = true

-- Indenting
vim.opt.tabstop     = 4
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4

-- Numbering
vim.opt.ruler          = false
vim.opt.number         = true
vim.opt.numberwidth    = 2
vim.opt.relativenumber = true

-- Behavior
vim.opt.wrap       = true
vim.opt.mouse      = ""
vim.opt.scrolloff  = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
vim.opt.backspace  = "indent,eol,start"
vim.opt.autoread   = true
vim.g.mapleader    = " "

-- Appearance
vim.opt.title         = true
vim.opt.cursorline    = true
vim.opt.colorcolumn   = "80,100,120"
vim.opt.termguicolors = true
vim.g.netrw_liststyle = 3
vim.g.netrw_banner    = false
vim.opt.signcolumn    = "yes"
vim.opt.winborder     = "rounded"

-- Text Processing
vim.opt.spell     = true
vim.opt.spelllang = "en_gb"
vim.opt.encoding  = "utf-8"
vim.opt.isfname:append("@-@", "{", "}")
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append "I"

-- Undoing & Backups
vim.opt.backup     = false
vim.opt.swapfile   = true
vim.opt.undodir    = os.getenv("XDG_STATE_HOME") .. "/nvimundo"
vim.opt.undofile   = true
vim.opt.updatetime = 50

-- Folding
vim.opt.foldmethod   = "indent"
vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.o.foldenable     = true
