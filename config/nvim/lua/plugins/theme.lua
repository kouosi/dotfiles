-- Config for kanagawa
-- local config = function()
--     local theme = require("kanagawa")
--     theme.setup{
--         transparent = true,
--         dimInactive = true,
--         terminalColors = true,
--     }
--     theme.load("wave")
-- end

-- Config for gruvbox
-- local config = function()
--     local theme = require("gruvbox")
--     theme.setup {
--         terminal_colors = true,
--         contrast = "soft",
--         dim_inactive = true,
--         transparent_mode = true,
--     }
--     theme.load("gruvbox")
--     -- vim.cmd("colorscheme gruvbox")
-- end

-- Config for everforest
-- local config = function()
--     local theme = require("everforest")
--     theme.setup({
--         background = "hard",
--         transparent_background_level = 1,
--         italics = true,
--     })
--     theme.load()
-- end

-- Config for shusia
local config = function()
  vim.cmd([[
    let g:sonokai_style = 'shusia'
    let g:sonokai_better_performance = 1
    let g:sonokai_transparent_background = 1
    colorscheme sonokai
    let g:lightline = {'colorscheme' : 'sonokai'}
  ]])
end

local M = {
    -- "rebelot/kanagawa.nvim",
    -- "ellisonleao/gruvbox.nvim",
    -- "neanias/everforest-nvim",
    "sainnhe/sonokai",
    config = config,
    lazy   = false,
    priority = 1000
}

return { M }
