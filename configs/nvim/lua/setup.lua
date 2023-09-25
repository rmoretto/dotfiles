local fs = vim.fs
local fn = vim.fn

require("install")
require("config")
require("keymaps")
local utils = require("utils")

-- Load and require all plugins
local HOME = fn.expand("$HOME")
local plugins_dir = HOME .. "/.config/nvim/lua/plugins"

for path, path_type in fs.dir(plugins_dir) do
	if path_type == "file" or path_type == "link" then
		local require_file = path:gsub("%.lua", "")
		require("plugins." .. require_file)
	end
end
