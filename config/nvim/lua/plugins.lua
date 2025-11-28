vim.api.nvim_create_autocmd("PackChanged", {
    callback = function (ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "LuaSnip" and (kind == "install" or kind == "update") then
            vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
        end
        if name == "treesitter" and (kind == "install" or kind == "update") then
            vim.cmd(":TSUpdate")
        end
    end
})

vim.pack.add({
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/RRethy/vim-illuminate",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/ixru/nvim-markdown",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- telescope dependency
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/kevinhwang91/promise-async", -- nvim-ufo dependency
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp", -- cmp dependency
    "https://github.com/hrsh7th/cmp-path", -- cmp dependency
    "https://github.com/hrsh7th/cmp-buffer", -- cmp dependency
    "https://github.com/hrsh7th/cmp-calc", -- cmp dependency
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

require("Comment").setup()

require("ibl").setup()

require("illuminate").configure({
    providers              = { "lsp", "treesitter", "regex" },
    case_insensitive_regex = true,
    under_cursor           = true,
    large_file_cutoff      = 16000,
    delay                  = 80,
    min_count_to_highlight = 2,
})

require("gitsigns").setup({
    signs = {
        add          = { text = "+" },
        change       = { text = "@" },
        delete       = { text = "-" },
        topdelete    = { text = "‾" },
        changedelete = { text = "_" },
        untracked    = { text = "?" },
    },
})
vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

local gruvbox = require("gruvbox")
gruvbox.setup({
    contrast         = "soft",
    dim_inactive     = true,
    transparent_mode = true,
})
gruvbox.load()

require("lualine").setup({
    options = { theme = require("lualine.themes.gruvbox") },
    tabline  = {},
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    },
})

vim.g.vim_markdown_conceal = 0

require("nvim-treesitter.configs").setup({
    auto_install     = true,
    ensure_installed = {
        "c", "zig","bash", "lua", "make",
        "markdown", "markdown_inline", "vim", "vimdoc",
        "diff", "gitcommit", "gitignore", "git_rebase",
        "comment", "json", "yaml", "xml",
    },
    indent    = { enable = true },
    highlight = {
        additional_vim_regex_highlighting = true,
        enable                            = true,
    },
    incremental_selection = {
        enable  = true,
        keymaps = {
            scope_incremental = false,
            init_selection    = "<C-b>",
            node_incremental  = "<C-n>",
            node_decremental  = "<C-m>",
        },
    },
})

require("treesitter-context").setup{
    enable              = true,
    zindex              = 32,
    multiline_threshold = 16,
}

require("nvim-highlight-colors").setup({})

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
require("telescope").setup({
    defaults = {
        mappings = {
            i = { ["<C-u>"] = false },
        },
    },
    pickers = {
        find_files = { theme = "ivy" },
        live_grep  = { theme = "ivy" },
        buffers    = { theme = "ivy" },
        help_tags  = { theme = "ivy" },
    },
})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find , {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files , {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep , {})
vim.keymap.set("n", "<leader>fgc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>fgf", builtin.git_files , {})
vim.keymap.set("n", "<leader>fgs", builtin.git_status, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags , {})
vim.keymap.set("n", "<leader>fj", builtin.jumplist, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fl", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>fm", builtin.man_pages, {})
vim.keymap.set("n", "<leader>fn", builtin.spell_suggest, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})
vim.keymap.set("n", "<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("Search > ") })
end)

local ufo = require("ufo")
ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "calc" },
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                luasnip  = "⋗",
                buffer   = "Ω",
                path     = "🖫",
                nvim_lua = "Π",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
    window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-m>"]     = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"]     = cmp.mapping.select_next_item(cmp_select),
        ["<C-b>"]     = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
})
