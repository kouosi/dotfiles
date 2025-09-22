local config = function()
    local ts_ctx = require("treesitter-context")
    ts_ctx.setup{
        enable = true,
        multiline_threshold = 16,
        zindex = 32
    }
end

local M = {
    "nvim-treesitter/nvim-treesitter-context",
    config = config,
    lazy   = false
}

return { M }
