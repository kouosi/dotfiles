local config = function()
    vim.opt.termguicolors = true,
    require("nvim-tree").setup({
        sort = { sorter = "case_sensitive" },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false }
    })
end

local M = {
    "nvim-tree/nvim-tree.lua",
    config       = config,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy         = false
}

return { M }
