-- Add a new line to the end of the file before saving
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup('UserOnSave', {}),
    pattern = "*",
    callback = function()

        -- Get file type
        local file_type = vim.bo.filetype

        -- List of file types that should trigger LSP format
        local lsp_format_types = {"html", 'c', 'cpp', 'python', 'zig'}

        if vim.fn.index(lsp_format_types, file_type) ~= -1 then
            vim.lsp.buf.format()
        end
    end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

