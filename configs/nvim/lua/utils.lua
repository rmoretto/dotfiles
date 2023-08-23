local fs = vim.fs
local fn = vim.fn

local _M = {}

_M.get_lua_modules = function(nvim_lua_dir, prefix)
	local lua_modules = {}
	for path, path_type in fs.dir(nvim_lua_dir) do
		if path_type == "file" and path:match("%.lua") then
			local module = path:gsub("%.lua", "")

			if prefix then
				module = prefix .. "." .. module
			end

			table.insert(lua_modules, module)
		elseif path_type == "directory" then
			local next_path = nvim_lua_dir .. "/" .. path
			local next_prefix = path
			if prefix then
				next_prefix = prefix .. "." .. next_prefix
			end

			local mods = _M.get_lua_modules(next_path, next_prefix)

			for _, v in ipairs(mods) do
				table.insert(lua_modules, v)
			end
		end
	end

	return lua_modules
end

_M.reload_lua = function()
	local HOME = fn.expand("$HOME")
	local nvim_lua_dir = HOME .. "/.config/nvim/lua"

	local modules = _M.get_lua_modules(nvim_lua_dir)

	for _, mod in pairs(modules) do
		package.loaded[mod] = nil
	end

	for name, _ in pairs(package.loaded) do
		if name:match("^cnull") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end

_M.reload_nvim = function()
	-- vim.cmd([[source "~/.config/nvim/init.lua"]], true)
	_M.reload_lua()
	vim.cmd("e")

	vim.notify("Reloaded Neovim", vim.log.levels.INFO)
end

_M.inspect = function(p)
	vim.notify(vim.inspect(p), vim.log.levels.INFO)
end

_M.set_timeout = function(timeout, callback)
	local timer = vim.loop.new_timer()

	timer:start(timeout, 0, function()
		timer:stop()
		timer:close()
		callback()
	end)

	return timer
end

return _M
