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

-- relative numbering when in normal mode.
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.conceallevel = 0
        vim.opt_local.colorcolumn = ""
        vim.opt_local.relativenumber = true
    end
})

-- Prefer Neovim terminal insert mode to normal mode.
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "term://*",
    command = "startinsert"
})

require('lspconfig').typos_lsp.setup({
    -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
    cmd_env = { RUST_LOG = "error" },
    init_options = {
        -- Custom config. Used together with a config file found in the workspace or its parents,
        -- taking precedence for settings declared in both.
        -- Equivalent to the typos `--config` cli argument.
        config = '~/.config/typos.toml',
        -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
        -- Defaults to error.
        diagnosticSeverity = "Warning"
    }
})
