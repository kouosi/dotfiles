local config = function()
    require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end
    })
end

local M = {
    "kevinhwang91/nvim-ufo",
    config       = config,
    dependencies = {"kevinhwang91/promise-async"},
    lazy         = false
}

return { M }
