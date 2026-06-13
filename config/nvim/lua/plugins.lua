local km = require("keymaps")

local function pack_changed_callback(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "LuaSnip" and (kind == "install" or kind == "update") then
		vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path })
	end
	if name == "treesitter" and (kind == "install" or kind == "update") then
		vim.cmd(":TSUpdate")
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = pack_changed_callback })

vim.pack.add({
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/RRethy/vim-illuminate",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/ixru/nvim-markdown",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- dep:telescope
	"https://github.com/kevinhwang91/nvim-ufo",
	"https://github.com/kevinhwang91/promise-async", -- dep:nvim-ufo
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp", -- dep:cmp
	"https://github.com/hrsh7th/cmp-path", -- dep:cmp
	"https://github.com/hrsh7th/cmp-buffer", -- dep:cmp
	"https://github.com/hrsh7th/cmp-calc", -- dep:cmp
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/benomahony/oil-git.nvim", -- dep:oil
	"https://github.com/echasnovski/mini.icons", -- dep:lualine & oil
	"https://github.com/folke/which-key.nvim",
	"https://github.com/romus204/tree-sitter-manager.nvim",
})

-- Which Key
require("which-key").setup({ preset = "helix", })

-- Mini Icons
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

-- Oil
local function parse_output(proc)
	local result = proc:wait()
	local ret = {}
	if result.code == 0 then
		for line in vim.gsplit(result.stdout, "\n",
				{ plain = true, trimempty = true}) do
			ret[line:gsub("/$", "")] = true
		end
	end
	return ret
end

local function new_git_status_index(self, key)
	local ret = {
		ignored = parse_output(vim.system(
			{ "git", "ls-files", "--ignored", "--exclude-standard",
				"--others", "--directory" },
			{ cwd = key, text = true}
		)),
		tracked = parse_output(vim.system(
			{ "git", "ls-tree", "HEAD", "--name-only" },
			{ cwd = key, text = true }
		)),
	}
	rawset(self, key, ret)
	return ret
end

local function new_git_status()
	return setmetatable({}, { __index = new_git_status_index })
end

local git_status = new_git_status()

local refresh = require("oil.actions").refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
	git_status = new_git_status()
	orig_refresh(...)
end

local function oil_is_hidden_file(name, bufnr)
	local dir = require("oil").get_current_dir(bufnr)
	local is_dotfile = vim.startswith(name, ".") and name ~= ".."
	if not dir then
		return is_dotfile
	end
	if is_dotfile then
		return not git_status[dir].tracked[name]
	else
		return git_status[dir].ignored[name]
	end
end

require("oil").setup({
	columns = { "size", "icon" },
	delete_to_trash = true,
	preview_win = { disable_preview = true },
	view_options = { is_hidden_file = oil_is_hidden_file },
	prompt_save_on_select_new_entry = false,
})

-- Comment
require("Comment").setup()

-- Ibl
require("ibl").setup()

-- Illuminate
require("illuminate").configure({
	providers = { "lsp", "treesitter", "regex" },
	case_insensitive_regex = true,
	under_cursor = true,
	large_file_cutoff = 16000,
	delay = 80,
	min_count_to_highlight = 2,
})

-- Git signs
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "@" },
		delete = { text = "-" },
		topdelete = { text = "‾" },
		changedelete = { text = "_" },
		untracked = { text = "?" },
	},
})
km.map("n", "<leader>gp", ":Gitsigns preview_hunk <CR>", "Git sign preview hunk")
km.map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame <CR>","Git sign blame")

-- Gruvbox
local gruvbox = require("gruvbox")
gruvbox.setup({
	-- contrast = "soft",
	dim_inactive = true,
	-- transparent_mode = true,
})
gruvbox.load()

-- Lualine
require("lualine").setup({
	options = { theme = require("lualine.themes.gruvbox") },
	tabline = {},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Markdown
vim.g.vim_markdown_conceal = 0

-- Treesitter context
require("treesitter-context").setup{
	enable = true,
	zindex = 32,
	multiline_threshold = 16,
}

-- Nvim highlight
require("nvim-highlight-colors").setup({})

-- Telescope
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
		live_grep = { theme = "ivy" },
		buffers  = { theme = "ivy" },
		help_tags = { theme = "ivy" },
	},
})

local function get_lsp_root()
	local root_dir = nil
	local clients = vim.lsp.get_active_clients()
	for _, client in ipairs(clients) do
		if client.config and client.config.root_dir then
			root_dir = client.config.root_dir
			break
		end
	end
	if not root_dir then
		local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
		if git_root and vim.v.shell_error == 0 then
			root_dir = git_root
		end
	end
	return root_dir or vim.fn.getcwd()
end

local function live_grep_from_lsp_root()
	builtin.live_grep({ cwd = get_lsp_root() })
end

local function find_files_from_lsp_root()
	builtin.find_files({ cwd = get_lsp_root() })
end

km.map("n", "<leader>/", live_grep_from_lsp_root, "Live frep at lsp root")
km.map("n", "<leader>/b", builtin.current_buffer_fuzzy_find , "TS Fuzzy find current buff")
km.map("n", "<leader>/c", builtin.live_grep, "Live grep cwd")
km.map("n", "<leader>b", builtin.buffers, "TS Buffers")
km.map("n", "<leader>F", builtin.find_files, "Find file at cwd")
km.map("n", "<leader>f", find_files_from_lsp_root, "Find files at lsp root")
km.map("n", "<leader>o", builtin.oldfiles, "TS old files")
km.map("n", "<leader>gc", builtin.git_commits, "TS git commits")
km.map("n", "<leader>gf", builtin.git_files , "TS git files")
km.map("n", "<leader>gs", builtin.git_status, "TS git status")
km.map("n", "<leader>h", builtin.help_tags , "TS help tags")
km.map("n", "<leader>j", builtin.jumplist, "TS jump list")
km.map("n", "<leader>k", builtin.keymaps, "TS key maps")
km.map("n", "<leader>lD", builtin.lsp_type_definitions, "LSP Type definitions List")
km.map("n", "<leader>lS", builtin.lsp_workspace_symbols, "LSP Workspace symbols List")
km.map("n", "<leader>ld", builtin.lsp_definitions, "LSP Definitions List")
km.map("n", "<leader>li", builtin.lsp_implementations, "LSP Implementations List")
km.map("n", "<leader>lq", builtin.lsp_dynamic_workspace_symbols, "LSP Dynamic workspace symbols List")
km.map("n", "<leader>lr", builtin.lsp_references, "LSP References Listj")
km.map("n", "<leader>ls", builtin.lsp_document_symbols, "LSP Document symbols List")
km.map("n", "<leader>m", builtin.man_pages, "TS Man pages")
km.map("n", "<leader>q", builtin.quickfix, "TS quick fix")
km.map("n", "<leader>s", builtin.spell_suggest, "TS spell suggest")
km.map("n", "<leader>v", builtin.diagnostics, "TS Diagnostics List")

vim.opt.timeoutlen = 320

-- UFO
local ufo = require("ufo")
ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end
})


-- CMP
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local function cmp_format(entry, item)
	-- Helper function to truncate a string if it's wider than a given limit
	local function truncate(str, max_width, ellipsis)
		ellipsis = ellipsis or "..."
		local ellipsis_width = vim.fn.strwidth(ellipsis)

		if not str or vim.fn.strwidth(str) <= max_width then
			return str
		end

		local truncated_str = str
		while vim.fn.strwidth(truncated_str) > max_width - ellipsis_width do
			truncated_str = vim.fn.strcharpart(truncated_str, 0,
				vim.fn.strcharlen(truncated_str) - 1)
		end
		return truncated_str .. ellipsis
	end

	local menu_icon = {
		nvim_lsp = "λ",
		luasnip = "⋗",
		buffer = "Ω",
		path = "🖫",
		nvim_lua = "Π",
		calc = "🖩",
	}
	item.menu = menu_icon[entry.source.name]

	local maxwidth_abbr = 40
	local ellipsis_char = "..."
	item.abbr = truncate(item.abbr, maxwidth_abbr, "...")
	return item
end

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
		format = cmp_format,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-m>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-b>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})

-- Treesitter manager
require("tree-sitter-manager").setup({
	auto_install = true,
	noauto_install = {
		"c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc"
	},
	auto_install = {
		"zig", "bash", "make",
		"diff", "gitcommit", "gitignore", "git_rebase",
		"comment", "json", "yaml", "xml",
	},
	nohighlight = {},
})
