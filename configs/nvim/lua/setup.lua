local utils = require("utils")
local fs = vim.fs
local fn = vim.fn

require("install")
require("config")
require("keymaps")

-- Load plugins
local HOME = fn.expand("$HOME")
local plugins_dir = HOME .. "/.config/nvim/lua/plugins"

for path, path_type in fs.dir(plugins_dir) do
    if path_type == "file" then
        local require_file = path:gsub("%.lua", "")
        require("plugins." .. require_file)
    end
end

