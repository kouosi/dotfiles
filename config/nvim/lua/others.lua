vim.api.nvim_create_augroup("kouosi", { clear = true })

-- Strip white space from file on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group    = "kouosi",
    pattern  = "*",
    callback = function ()
        vim.cmd([[keeppatterns %substitute/\v\s+$//eg]])
    end,
})

-- Clear jumps when opening
vim.api.nvim_create_autocmd("VimEnter", {
    group    = "kouosi",
    callback = function()
        vim.cmd("clearjumps")
    end,
})

-- Make folders when saving file from taken from mkdir.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
    group    = "kouosi",
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if dir:match("^%l+://") then
            return
        end
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end
})
