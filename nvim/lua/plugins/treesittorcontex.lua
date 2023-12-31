local config = function()
    require("treesitter-context").setup{
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

