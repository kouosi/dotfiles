local config = function()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
        signs = {
            add          = { text = "+" },
            change       = { text = "@" },
            delete       = { text = "-" },
            topdelete    = { text = "‾" },
            changedelete = { text = "_" },
            untracked    = { text = "?" },
        },
    })
    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})
end

local M = {
    "lewis6991/gitsigns.nvim",
    config = config,
    lazy   = false
}

return { M }
