-- local config = function()
--     local theme = require("onedark")
--     theme.setup{
--         style = "darker"
--     }
--     theme.load()
-- end

local config = function()
    local theme = require("kanagawa")
    theme.setup{
        transparent = true,
        dimInactive = true,
        terminalColors = true,
    }
    theme.load("wave")
end

local M = {
    -- "navarasu/onedark.nvim",
    "rebelot/kanagawa.nvim",
    config = config,
    lazy   = false
}

return { M }

