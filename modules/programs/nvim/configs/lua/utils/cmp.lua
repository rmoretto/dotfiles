local M = {}

-- Ref: https://github.com/LazyVim/LazyVim/blob/a33eabddd9f3786421652d07894516d946c88647/lua/lazyvim/util/cmp.lua#L84
M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.confirm(opts)
	local cmp = require("cmp")
	opts = vim.tbl_extend("force", {
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}, opts or {})

	return function(fallback)
		if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
			if vim.api.nvim_get_mode().mode == "i" then
				vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
			end

			if cmp.confirm(opts) then
				return
			end
		end
		return fallback()
	end
end

return M
