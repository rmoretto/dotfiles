local function augroup(name)
	return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Configure ts, sts and sw for langs
local lang_opts = {
	{ "elixir", ts = 2, sts = 2, sw = 2 },
	{ "javascript", ts = 2, sts = 2, sw = 2 },
	{ "typescript", ts = 2, sts = 2, sw = 2 },
	{ "vue", ts = 2, sts = 2, sw = 2 },
	{ "html", ts = 2, sts = 2, sw = 2 },
	{ "css", ts = 2, sts = 2, sw = 2 },
	{ "scss", ts = 2, sts = 2, sw = 2 },
	{ "dart", ts = 2, sts = 2, sw = 2 },
	{ "hcl", ts = 2, sts = 2, sw = 2 },
	{ "terraform", ts = 2, sts = 2, sw = 2 },
	{ "json", ts = 2, sts = 2, sw = 2 },
	{ "nix", ts = 2, sts = 2, sw = 2 },
}

for _, opt in pairs(lang_opts) do
	local lang = opt[1]
	local ts = opt.ts
	local sts = opt.sts
	local sw = opt.sts

	vim.api.nvim_create_autocmd("FileType", {
		pattern = lang,
		callback = function(_event)
			vim.opt_local.tabstop = ts
			vim.opt_local.softtabstop = sts
			vim.opt_local.shiftwidth = sw
		end,
	})
end
