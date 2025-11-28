vim.api.nvim_create_augroup("kouosi_lsp", { clear = true })

vim.lsp.enable({
    "gopls",
    "lua_ls",
    "pyright",
    "clangd",
    "zls",
})

-- vim.lsp.inlay_hint.enable(true)

-- LSP format if supported
vim.api.nvim_create_autocmd("BufWritePre", {
    group    = "kouosi_lsp",
    pattern  = "*",
    callback = function(ev)
        vim.lsp.buf.format({
            filter = function(client)
                return client.supports_method("textDocument/formatting")
            end,
            bufnr = ev.buf,
        })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    group    = "kouosi_lsp",
    callback = function (ev)
        local buf_opts = { noremap = true, silent = true, buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, buf_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, buf_opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, buf_opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, buf_opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, buf_opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, buf_opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, buf_opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, buf_opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, buf_opts)
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true})
        -- end
    end
})
