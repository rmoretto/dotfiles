local function mix_format()
	return { exe = "mix", args = { "format", "mix.exs", "-" }, stdin = true }
end

local function terraform()
	return { exe = "terraform", args = { "fmt", "-write=false" }, stdin = true }
end

local stylua = require("formatter.filetypes.lua").stylua
local prettier = require("formatter.filetypes.javascript").prettier
local black = require("formatter.filetypes.python").black
local rustfmt = {
    exe = "rustfmt --edition 2021",
    stdin = true,
  }

require("formatter").setup({
	logging = true,
	filetype = {
		elixir = { mix_format },
		lua = { stylua },
		javascript = { prettier },
		javascriptreact = { prettier },
		typescript = { prettier },
		typescriptreact = { prettier },
		vue = { prettier },
		html = { prettier },
		json = { prettier },
		css = { prettier },
		scss = { prettier },
		sass = { prettier },
		python = { black },
		rust = { rustfmt },
		terraform = { terraform },
	},
})

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>f", ":Format<CR> :w<CR>", opts)
