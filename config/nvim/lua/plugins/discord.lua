local opts = function()
    return {
        editor = {
            client = '<YOUR_CLIENT_TOKEN>',
        },
    }
end

local M = {
    'vyfor/cord.nvim',
    build = ':Cord update',
    opts = opts,
}

return { M }
