local opt = { noremap = true, silent = true }

-- pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-j>", "<C-w>j", opt)
vim.keymap.set("n", "<C-k>", "<C-w>k", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)

-- win management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opt)
vim.keymap.set("n", "<leader>sh", ":split<CR>", opt)

-- File explorer
vim.keymap.set("n", "<leader>fm", ":28Lexplore<CR>", opt)

-- Disable Arrow keys
vim.keymap.set("n", "<Up>", "<Nop>", opt)
vim.keymap.set("n", "<Down>", "<Nop>", opt)
vim.keymap.set("n", "<Left>", "<Nop>", opt)
vim.keymap.set("n", "<Right>", "<Nop>", opt)

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext <CR>", opt)
vim.keymap.set("n", "<S-Tab>", ":bprevious <CR>", opt)
vim.keymap.set("n", "<leader>d", ":bd! <CR>", opt)

-- Others
vim.keymap.set("n", "<leader>ld", ":Lazy load cord.nvim <CR>", opt)
