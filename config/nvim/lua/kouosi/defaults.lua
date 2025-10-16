-- Some Config to overwrite neovim default behaviour

-- Searching
vim.opt.hlsearch   = true
vim.opt.ignorecase = true
vim.opt.incsearch  = true
vim.opt.smartcase  = true

-- Indenting
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop     = 4

-- Numbering
vim.opt.number         = true
vim.opt.numberwidth    = 2
vim.opt.relativenumber = true
vim.opt.ruler          = false

-- Looks & Behavior
vim.opt.autochdir     = false
vim.opt.colorcolumn   = "80,100,120"
vim.opt.cursorline    = true
vim.opt.encoding      = "utf-8"
vim.opt.mouse         = ""
vim.opt.scrolloff     = 8
vim.opt.signcolumn    = "yes"
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.termguicolors = true
vim.opt.timeoutlen    = 400
vim.opt.wrap          = true
vim.g.netrw_banner    = false
vim.g.netrw_liststyle = 3
vim.opt.title         = true
vim.opt.isfname:append("@-@", "{", "}")
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append "I"

-- Undoing & Backups
vim.opt.backup     = false
vim.opt.swapfile   = true
vim.opt.undodir    = os.getenv("XDG_STATE_HOME") .. "/nvimundo"
vim.opt.undofile   = true
vim.opt.updatetime = 50

-- Fold
vim.o.foldcolumn     = '1'
vim.o.foldlevel      = 99
vim.o.foldlevelstart = 99
vim.o.foldenable     = true

-- plugins:nvim-markdown
vim.g.vim_markdown_conceal = 0
