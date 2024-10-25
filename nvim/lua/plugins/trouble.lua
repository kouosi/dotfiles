local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {},
    --     fold_closed = ">",
    --     fold_open = "v",
    --     icons = false,
    --     indent_lines = false,
    --     signs = {
    --         error = "error",
    --         warning = "warn",
    --         hint = "hint",
    --         information = "info"
    --     },
    --     use_diagnostic_signs = true
    -- },
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        }, {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        }
    },
}

return { M }
