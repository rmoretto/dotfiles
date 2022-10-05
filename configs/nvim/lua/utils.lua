
local _M = {}

_M.reload_nvim = function()
    vim.notify("minha fncao :)", vim.log.levels.INFO)
    vim.cmd([[source "~/.config/nvim/init.lua"]], true)
end

_M.inspect = function(p)
    vim.notify(vim.inspect(p), vim.log.levels.INFO)
end

_M.set_timeout = function(timeout, callback)
  local timer = vim.loop.new_timer()

  timer:start(timeout, 0, function ()
    timer:stop()
    timer:close()
    callback()
  end)

  return timer
end

return _M
