local config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
        auto_install = true,
        ensure_installed = { "c", "bash", "lua", "vim", "vimdoc", "query",
                            "javascript", "html", "css", "diff", "gitcommit",
                            "gitignore", "git_rebase", "json", "latex",
                            "make", "markdown", "yaml", "xml", "comment"
                        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true
        },
        incremental_selection = {
            enable  = true,
            keymaps = {
                init_selection    = "<C-b>",
                node_incremental  = "<C-n>",
                scope_incremental = false,
                node_decremental  = "<C-m>"
            }
        },
        indent       = { enable = true },
        sync_install = false
    })
end

local M = {
    "nvim-treesitter/nvim-treesitter",
    build        = ":TSUpdate",
    config       = config,
    lazy         = false
}

return { M }

