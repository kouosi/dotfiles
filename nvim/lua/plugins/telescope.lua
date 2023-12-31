local config = function()
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mapping = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous"
                }
            }
        }
    })
    local builtin = require('telescope.builtin')
	vim.keymap.set("n", "<leader>tb",  builtin.buffers, {})
    vim.keymap.set("n", "<leader>td",  builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>tff", builtin.current_buffer_fuzzy_find , {})
    vim.keymap.set("n", "<leader>tfg", builtin.live_grep , {})
    vim.keymap.set("n", "<leader>tfr", builtin.find_files , {})
    vim.keymap.set("n", "<leader>tfv", builtin.quickfix, {})
    vim.keymap.set("n", "<leader>tgc", builtin.git_commits, {})
    vim.keymap.set("n", "<leader>tgf", builtin.git_files , {})
    vim.keymap.set("n", "<leader>tgs", builtin.git_status, {})
    vim.keymap.set("n", "<leader>th",  builtin.help_tags , {})
    vim.keymap.set("n", "<leader>tk",  builtin.keymaps, {})
    vim.keymap.set("n", "<leader>tl",  builtin.lsp_definitions, {})
    vim.keymap.set("n", "<leader>tm",  builtin.man_pages, {})
    vim.keymap.set("n", "<leader>tof", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>tt",  builtin.treesitter, {})
    vim.keymap.set('n', '<leader>ts',  function()
        builtin.grep_string({ search = vim.fn.input("Search > ") })
    end)
end

local M = {
    'nvim-telescope/telescope.nvim',
    branch       = '0.1.x',
    config       = config,
    dependencies = {'nvim-lua/plenary.nvim'},
    lazy         = false
}

return { M }

