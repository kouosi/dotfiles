vim.g.mapleader = " "

local options = { noremap = true, silent = true }

-- pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-j>", "<C-w>j", options)
vim.keymap.set("n", "<C-k>", "<C-w>k", options)
vim.keymap.set("n", "<C-l>", "<C-w>l", options)

-- win management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", options)
vim.keymap.set("n", "<leader>sh", ":split<CR>", options)

-- File explorer
vim.keymap.set("n", "<leader>fm", ":28Lexplore<CR>", options)

-- Disable Arrow keys
vim.keymap.set("n", "<Up>", "<Nop>", options)
vim.keymap.set("n", "<Down>", "<Nop>", options)
vim.keymap.set("n", "<Left>", "<Nop>", options)
vim.keymap.set("n", "<Right>", "<Nop>", options)

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext <CR>", options)
vim.keymap.set("n", "<S-Tab>", ":bprevious <CR>", options)
vim.keymap.set("n", "<leader>d", ":bd! <CR>", options)

-- Others
vim.keymap.set("n", "<leader>ld", ":Lazy load cord.nvim <CR>", options)
