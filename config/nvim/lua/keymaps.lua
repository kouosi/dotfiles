local M = {}

function M.map(mode, map_as, map_to, desc)
    vim.keymap.set(mode, map_as, map_to, { noremap = true, silent = true, desc = desc })
end

-- win management
M.map("n", "<leader>sv", ":vsplit<CR>", "Vertically split window")
M.map("n", "<leader>sh", ":split<CR>", "Horizontally split window")

-- Disable Arrow keys
M.map("n", "<Up>", "<Nop>")
M.map("n", "<Down>", "<Nop>")
M.map("n", "<Left>", "<Nop>")
M.map("n", "<Right>", "<Nop>")

-- Buffer navigation
M.map("n", "<Tab>", ":bnext <CR>", "Goto next buffer")
M.map("n", "<S-Tab>", ":bprevious <CR>", "Goto previous buffer")
M.map("n", "<leader>bd", ":bd! <CR>", "Close current buffer")

-- Others
M.map("n", "<leader>e", ":Oil <CR>", "Open Oil")

return M
