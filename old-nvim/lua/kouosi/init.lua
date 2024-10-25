require("kouosi.defaults")
require("kouosi.keybinds")
require("kouosi.packer")

-- Add a new line to the end of the file before saving
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup('UserOnSave', {}),
    pattern = "*",
    callback = function()

        -- Get file type
        local file_type = vim.bo.filetype

        -- List of file types that should trigger LSP format
        local lsp_format_types = {'c', 'cpp', 'python', 'zig'}

        if vim.fn.index(lsp_format_types, file_type) ~= -1 then
            -- Save the cursor position
            local cursor_pos = vim.fn.getcurpos()
            -- Format with lsp
            vim.lsp.buf.format()
            -- Restore the cursor position
            vim.fn.setpos('.', cursor_pos)
            -- Add a new line to the end of the file
            local current_buf = 0
            local total_lines = vim.api.nvim_buf_line_count(current_buf)
            vim.api.nvim_buf_set_lines(current_buf, total_lines, total_lines, true, {''})
        else
            local n_lines = vim.api.nvim_buf_line_count(0)
            local last_nonblank = vim.fn.prevnonblank(n_lines)
            if last_nonblank <= n_lines then vim.api.nvim_buf_set_lines(0,
                last_nonblank, n_lines, true, { '' })
            end
        end
    end
})
