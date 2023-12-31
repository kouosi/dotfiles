local config = function()
    local theme = require("onedark")
    theme.setup{
        style = "darker"
    }
    theme.load()
end

local M = {
    "navarasu/onedark.nvim",
    config = config,
    lazy   = false
}

return { M }

