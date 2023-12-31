vim.g.mapleader = " "

local options = {
    noremap = true,
    silent = true
}
-- Nvim tree
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", options)
vim.keymap.set("n", "<leader>pf", ":NvimTreeFocus<CR>", options)

-- pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", options)
vim.keymap.set("n", "<C-j>", "<C-w>j", options)
vim.keymap.set("n", "<C-k>", "<C-w>k", options)
vim.keymap.set("n", "<C-l>", "<C-w>l", options)

-- win management
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", options)
vim.keymap.set("n", "<leader>sh", ":split<CR>", options)
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", options)

-- Esc key is pain in ash
vim.keymap.set("i", "jk", "<Esc>")

-- Disable Arrow keys
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', options)
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', options)

