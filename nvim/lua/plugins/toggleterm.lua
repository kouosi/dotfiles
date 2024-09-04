local config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup {
        size = 10,
        open_mapping = "<c-s>",
        border = 'double',
        direction =  'tab',
    }
end

local M = {
    "akinsho/toggleterm.nvim",
    config = config,
    lazy   = false
}

return { M }

