function _G.get_oil_winbar()
    local oil   = require("oil")
    local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
    local dir   = oil.get_current_dir(bufnr)
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        return vim.api.nvim_buf_get_name(0)
    end
end

local function parse_output(proc)
    local result = proc:wait()
    local ret    = {}
    if result.code == 0 then
        for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
            -- Remove trailing slash
            line      = line:gsub("/$", "")
            ret[line] = true
        end
    end
    return ret
end

local function new_git_status()
    return setmetatable({}, {
        __index = function(self, key)
            local ignore_proc = vim.system(
                { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
                { cwd = key, text = true }
            )
            local tracked_proc = vim.system(
                { "git", "ls-tree", "HEAD", "--name-only" },
                { cwd = key, text = true, }
            )
            local ret = {
                ignored = parse_output(ignore_proc),
                tracked = parse_output(tracked_proc),
            }

            rawset(self, key, ret)
            return ret
        end,
    })
end
local git_status = new_git_status()

-- Clear git status cache on refresh
-- local refresh = require("oil.actions").refresh
-- local orig_refresh = refresh.callback
-- refresh.callback = function(...)
--   git_status = new_git_status()
--   orig_refresh(...)
-- end

local config = function()
    local oil   = require("oil")
    oil.setup({
        default_file_explorer = true,
        columns           = { "size", "icon" },
        win_options       = { winbar = "%!v:lua.get_oil_winbar()" },
        delete_to_trash   = true,
        watch_for_changes = true,
        view_options      = {
            case_insensitive = false,
            show_hidden      = false,
            is_hidden_file   = function(name, bufnr)
                local dir        = oil.get_current_dir(bufnr)
                local is_dotfile = vim.startswith(name, ".") and name ~= ".."
                -- if no local directory (e.g. for ssh connections), just hide dotfiles
                if not dir then
                    return is_dotfile
                end
                -- dotfiles are considered hidden unless tracked
                if is_dotfile then
                    return not git_status[dir].tracked[name]
                else
                  -- Check if file is gitignored
                    return git_status[dir].ignored[name]
                end
            end,
        },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

local M = {
    "stevearc/oil.nvim",
    config       = config,
    lazy         = false,
    dependencies = {
        { "echasnovski/mini.icons", opts = {} }
    },
}

return { M }
