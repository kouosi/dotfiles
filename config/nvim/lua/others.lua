vim.api.nvim_create_augroup("kouosi", { clear = true })

-- Strip white space from file on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "kouosi",
	pattern = "*",
	callback = function ()
		if vim.bo.filetype == "diff" or vim.bo.filetype == "git" then
			return
		end
		vim.cmd([[keeppatterns %substitute/\v\s+$//eg]])
	end,
})

-- Clear jumps when opening
vim.api.nvim_create_autocmd("VimEnter", {
	group = "kouosi",
	callback = function()
		vim.cmd("clearjumps")
	end,
})

-- Make folders when saving file from taken from mkdir.nvim
vim.api.nvim_create_autocmd("BufWritePre", {
	group = "kouosi",
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

local viewers = {
	{ command = "okular", patterns = { "*.pdf" } },
	{ command = "imv", patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" } },
	{ command = "mpv", patterns = { "*.mp4", "*.webm", "*.mkv" } },
}

local group = vim.api.nvim_create_augroup("ExternalViewers", { clear = true })

local function register_viewer(command, patterns)
	vim.api.nvim_create_autocmd("BufReadCmd", {
		group = group,
		pattern = patterns,
		callback = function(event)
			local filename = vim.api.nvim_buf_get_name(event.buf)
			local job = vim.fn.jobstart({ command, filename }, { detach = true })
			if job <= 0 then
				vim.notify("Failed to start " .. command, vim.log.levels.ERROR)
				return
			end
			local alternate = vim.fn.bufnr("#")
			if alternate ~= event.buf and vim.api.nvim_buf_is_valid(alternate) then
				vim.api.nvim_set_current_buf(alternate)
			else
				vim.cmd.enew()
			end
			vim.api.nvim_buf_delete(event.buf, { force = true })
		end,
	})
end

for _, viewer in ipairs(viewers) do
	register_viewer(viewer.command, viewer.patterns)
end

})
