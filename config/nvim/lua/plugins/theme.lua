-- Config for gruvbox
local config = function()
    local theme = require("gruvbox")
    theme.setup {
        terminal_colors = true,
        contrast = "soft",
        dim_inactive = true,
        transparent_mode = true,
    }
    theme.load("gruvbox")
end

local M = {
    "ellisonleao/gruvbox.nvim",
    config = config,
    lazy   = false,
    priority = 1000
}

return { M }
