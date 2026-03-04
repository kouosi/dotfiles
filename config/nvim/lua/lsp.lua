vim.api.nvim_create_augroup("kouosi_lsp", { clear = true })

vim.cmd([[
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
    autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2
    autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2
]])

local all_lsps = {
    { "gopls" },
    { "lua_ls" },
    { "css" },
    { "html" },
    { "eslint" },
    { "jsonls" },
    { "pyright" },
    { "ts_ls" },
    { "zls" },
    { "clangd", {
        cmd = {
            "clangd",
            "--background-index",
            "--pch-storage=memory",
            "--clang-tidy",
            "-j=2",
            "--all-scopes-completion",
            "--completion-style=detailed",
            "--header-insertion-decorators",
            "--header-insertion=never",
        },
        filetypes = { "c", "cpp", "arduino" },
    }},
}

for _, lsp in pairs(all_lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    else
        vim.lsp.config(name, {})
    end
end

-- vim.lsp.inlay_hint.enable(true)

-- LSP format if supported
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group    = "kouosi_lsp",
--     pattern  = "*",
--     callback = function(ev)
--         vim.lsp.buf.format({
--             filter = function(client)
--                 return client.supports_method("textDocument/formatting")
--             end,
--             bufnr = ev.buf,
--         })
--     end
-- })

vim.api.nvim_create_autocmd("LspAttach", {
    group    = "kouosi_lsp",
    callback = function (ev)
        local function map(mode, map_as, map_to, desc)
            vim.keymap.set(mode, map_as, map_to, { noremap = true, silent = true, buffer = ev.buf, desc = desc })
        end
        map("n", "<leader>dn", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>dp", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "<leader>d", vim.diagnostic.open_float, "Open diagnostic float")
        map("n", "gd", vim.lsp.buf.definition, "Goto LSP definition")
        map("n", "gD", vim.lsp.buf.declaration, "Goto LSP declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Goto LSP implementation")
        map("n", "gr", vim.lsp.buf.references, "Goto LSP references")
        map("n", "gt", vim.lsp.buf.type_definition, "Goto LSP type definition")
        map("n", "<leader>r", vim.lsp.buf.rename, "LSP rename symbol")
        map("n", "<leader>a", vim.lsp.buf.code_action, "LSP code action")
        map("n", "<leader>lf", vim.lsp.buf.format, "LSP format")
        map("n", "K", vim.lsp.buf.hover, "LSP Hover")
        map("i", "<C-s>", vim.lsp.buf.signature_help, "LSP Signature help")
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP Add workspace folder")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP Remove workspace folder")
        map("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "LSP List workspace folders")
        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true})
        -- end
    end
})
