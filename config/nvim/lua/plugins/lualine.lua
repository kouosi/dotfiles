local config  = function()
    local lualine = require("lualine")
    local gruvbox = require("lualine.themes.gruvbox")

    lualine.setup {
        options  = { theme = gruvbox },
        tabline  = {},
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
    }
end


local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config       = config,
    lazy         = false
}

return { M }
