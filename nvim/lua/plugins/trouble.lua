local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
        fold_closed = ">",
        fold_open = "v",
        icons = false,
        indent_lines = false,
        signs = {
            error = "error",
            warning = "warn",
            hint = "hint",
            information = "info"
        },
        use_diagnostic_signs = true
    }
}

return { M }

