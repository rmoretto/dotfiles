local cmp = require("cmp")
local types = require("cmp.types")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = {
		-- Nice
		["<C-f>"] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
			{ "i", "c" }
		),
		["<C-b>"] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
			{ "i", "c" }
		),

		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "vsnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "emoji" },
    { name = 'nvim_lsp', trigger_characters = { '-' } }
	},
})
