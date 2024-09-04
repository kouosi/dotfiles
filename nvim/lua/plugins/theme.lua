-- local config = function()
--     local theme = require("kanagawa")
--     theme.setup{
--         transparent = true,
--         dimInactive = true,
--         terminalColors = true,
--     }
--     theme.load("wave")
-- end

local config = function()
    local theme = require("gruvbox")
    theme.setup {
        terminal_colors = true,
        contrast = "soft",
        dim_inactive = true,
        transparent_mode = true,
    }
    vim.cmd("colorscheme gruvbox")
end

local M = {
    -- "rebelot/kanagawa.nvim",
    "ellisonleao/gruvbox.nvim",
    config = config,
    lazy   = false
}

return { M }
