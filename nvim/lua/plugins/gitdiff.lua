local config = function()
    require('gitsigns').setup({
        signs = {
            add          = { text = '+' },
            change       = { text = '@' },
            delete       = { text = '-' },
            topdelete    = { text = '‾' },
            changedelete = { text = '_' },
            untracked    = { text = '?' },
        },
    })
end

local M = {
    "lewis6991/gitsigns.nvim",
    config       = config,
    lazy         = false
}

return { M }
