local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
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
