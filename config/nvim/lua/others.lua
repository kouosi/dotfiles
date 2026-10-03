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

-- Open binary files
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = "*.pdf",
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !okular " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end
})

vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !imv " .. filename .. " &")
		vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
	end
})
