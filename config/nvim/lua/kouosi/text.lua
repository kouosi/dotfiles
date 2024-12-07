-- -- Add a new line to the end of the file before saving
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = vim.api.nvim_create_augroup('UserOnSave', {}),
--     pattern = "*",
--     callback = function()
--
--         -- Get file type
--         local file_type = vim.bo.filetype
--
--         -- List of file types that should trigger LSP format
--         local lsp_format_types = {''}
--
--         if vim.fn.index(lsp_format_types, file_type) ~= -1 then
--             vim.lsp.buf.format()
--         end
--     end
-- })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.opt.spelllang = 'en_gb'
vim.opt.spell = true
vim.cmd("map <Plug> <Plug>Markdown_FollowLink")

-- Local Lsp config
local lsp = require('lspconfig')
lsp.clangd.setup({
    cmd = {
        'clangd',
        '--background-index',
        '--pch-storage=memory',
        '--clang-tidy',
        '-j=2',
        '--clang-tidy',
        '--clang-tidy-checks=*',
        '--all-scopes-completion',
        '--cross-file-rename',
        '--completion-style=detailed',
        '--header-insertion-decorators',
        '--header-insertion=iwyu',
    },
    filetypes = {'c', 'cpp', 'arduino'},
    -- languages = {'c', 'c++', 'ino'}
})

lsp.zls.setup({
    cmd = {'zls'},
    filetypes = {'zig'},
    languages = {'zig'}
})
