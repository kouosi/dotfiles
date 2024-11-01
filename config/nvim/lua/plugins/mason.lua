local config = function()
    local mason = require("mason")
    mason.setup({
        ui = {
            icons = {
                package_installed   = "✓",
                package_pending     = "➜",
                package_uninstalled = "✗"
            }
        }
    })
end

local M = {
    "williamboman/mason.nvim",
    cmd    = "Mason",
    config = config,
    event  = "BufReadPre"
}

return { M }
