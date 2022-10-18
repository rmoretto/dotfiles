local awful = require("awful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local watch = require("awful.widget.watch")
local spawn = require("awful.spawn")
local rubato = require("modules.rubato")

local volume = {}

local GET_VOL_CMD = "amixer -D default sget Master"
local INC_VOL_CMD = "amixer -D default sset Master %s%%+"
local DEC_VOL_CMD = "amixer -D default sset Master %s%%-"

local function init()
	local refresh_rate = 1
	local default_step = 5

	local vol_bar = wibox.widget({
		max_value = 100,
		value = 0,
		forced_height = dpi(16),
		forced_width = 100,
		paddings = 1,
		shape = gears.shape.rounded_bar,
		widget = wibox.widget.progressbar,
	})

	volume.widget = wibox.widget({
		layout = wibox.layout.stack,
		vol_bar,
	})

	local bar_anim = rubato.timed({
		duration = 0.125,
		subscribed = function(pos)
			vol_bar.value = pos
		end,
	})

	local function update_bar(_, stdout)
		bar_anim.pos = vol_bar.value or 0

		local vol_level = string.match(stdout, "%[(%d?%d?%d?)%%%]")
		local vol_value = tonumber(vol_level)
		if not vol_value then
			print("err parsing vol level")
			return
		end

		bar_anim.target = vol_value
	end

	function volume:inc(s)
		local cmd = string.format(INC_VOL_CMD, s or default_step)
		spawn.easy_async(cmd, function(stdout)
			update_bar(volume.widget, stdout)
		end)
	end

	function volume:dec(s)
		local cmd = string.format(DEC_VOL_CMD, s or default_step)
		spawn.easy_async(cmd, function(stdout)
			update_bar(volume.widget, stdout)
		end)
	end

	volume.widget:buttons(gears.table.join(
		awful.button({}, 4, function()
			volume:inc()
		end),
		awful.button({}, 5, function()
			volume:dec()
		end)
	))

	watch(GET_VOL_CMD, refresh_rate, update_bar, volume.widget)
	return volume.widget
end

return setmetatable(volume, {
	__call = function(_, ...)
		return init(...)
	end,
})
