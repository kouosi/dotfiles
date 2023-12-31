local config = function() 
    local illuminate = require("illuminate")
    illuminate.configure({
        case_insensitive_regex = true,
        delay                  = 80,
        large_file_overrides   = nil,
        min_count_to_highlight = 2,
        under_cursor           = true
    })
end

local M = {
    "RRethy/vim-illuminate",
    lazy = false
}

return { M }

