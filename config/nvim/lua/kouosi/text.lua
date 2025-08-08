vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.opt.spelllang = 'en_gb'
vim.opt.spell = true
vim.cmd("map <Plug> <Plug>Markdown_FollowLink")

-- Local Lsp config for clangd
local lsp = require('lspconfig')
lsp.clangd.setup({
    cmd = {
        'clangd',
        '--background-index',
        '--pch-storage=memory',
        '--clang-tidy',
        '-j=2',
        '--all-scopes-completion',
        '--completion-style=detailed',
        '--header-insertion-decorators',
        '--header-insertion=never', -- iwyu
    },
    filetypes = {'c', 'cpp', 'arduino'},
})

-- Local Lsp config for zls
lsp.zls.setup({
    cmd = {'zls', '--log-file', 'zls.log'},
    filetypes = {'zig'},
    languages = {'zig'},
    settings = {
        zls = {
          -- enable_build_on_save = true,
          semantic_tokens = "partial",
        }
    }
})

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

vim.api.nvim_create_autocmd('BufWritePre',{
    pattern = {"*.zig", "*.zon"},
    callback = function(ev)
        vim.lsp.buf.format()
    end
})

-- Make folders when saving file from mkdir.nvim
vim.api.nvim_create_augroup('MkdirRun', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'MkdirRun',
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if dir:match('^%l+://') then
            return
        end

        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end
})
