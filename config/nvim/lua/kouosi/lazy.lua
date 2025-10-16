-- Download Lazy.nvim if not download
local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

-- Lazy.nvim config options
local lazy_options = {
    defaults = { lazy = true },
    install  = {
        colorscheme = { "gruvbox" }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin",
                "tarPlugin", "tohtml", "tutor", "zipPlugin"
            }
        }
    },
    checker = {
        enabled = true,
        notify = false
    },
    change_detection = { notify = true }
}

local lazy = require("lazy")
lazy.setup("plugins", lazy_options)
