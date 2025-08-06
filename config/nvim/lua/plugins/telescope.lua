local config = function()
    local telescope = require("telescope")
    local themes = require('telescope.themes')
    telescope.setup({
        defaults = {
            mapping = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-u>"] = false
                }
            },
        },
        pickers = {
            find_files = { theme = "ivy" },
            live_grep = { theme = "ivy" },
            buffers = { theme = "ivy" },
            help_tags = { theme = "ivy" },
        },
        extensions = {
            file_browser = {
                theme = "ivy",
                hijack_netrw = true,
                auto_depth = true,
                hide_parent_dir = true,
                prompt_path = true,
            }
        },
    })
    local builtin = require('telescope.builtin')
	vim.keymap.set("n", "<leader>fb",  builtin.buffers, {})
    vim.keymap.set("n", "<leader>fd",  builtin.diagnostics, {})
    vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find , {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep , {})
    vim.keymap.set("n", "<leader>ff", builtin.find_files , {})
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
    vim.keymap.set("n", "<leader>fgc", builtin.git_commits, {})
    vim.keymap.set("n", "<leader>fgf", builtin.git_files , {})
    vim.keymap.set("n", "<leader>fgs", builtin.git_status, {})
    vim.keymap.set("n", "<leader>fh",  builtin.help_tags , {})
    vim.keymap.set("n", "<leader>fk",  builtin.keymaps, {})
    vim.keymap.set("n", "<leader>fl",  builtin.lsp_definitions, {})
    vim.keymap.set("n", "<leader>mp",  builtin.man_pages, {})
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>ft",  builtin.treesitter, {})
    vim.keymap.set('n', '<leader>fs',  function()
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
