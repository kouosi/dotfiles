-- Strip white space from file on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- Enable Spelling check
vim.opt.spelllang = "en_gb"
vim.opt.spell     = true

-- FIX: markdown.nvim Enter key fix
vim.cmd("map <Plug> <Plug>Markdown_FollowLink")

-- Enable Inlay hint for lsp
-- vim.lsp.inlay_hint.enable(true)

-- Local Lsp config for clangd
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
    cmd = {
        "clangd",
        "--background-index",
        "--pch-storage=memory",
        "--clang-tidy",
        "-j=2",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion-decorators",
        "--header-insertion=never", -- iwyu
    },
    filetypes = { "c", "cpp", "arduino" },
})

-- Local Lsp config for zls
lspconfig.zls.setup({
    cmd       = { "zls" },
    filetypes = { "zig" },
    languages = { "zig" },
    settings  = {
        zls = {
            semantic_tokens = "partial"
        }
    }
})

vim.api.nvim_create_autocmd("BufWritePre",{
    pattern = { "*.zig", "*.zon" },
    callback = function(ev)
        vim.lsp.buf.format()
    end
})

-- Make folders when saving file from mkdir.nvim
vim.api.nvim_create_augroup("MkdirRun", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "MkdirRun",
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
