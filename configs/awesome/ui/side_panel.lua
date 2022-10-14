local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local beautiful = require("beautiful")
local rubato = require("modules.rubato")

local function close_button(side_panel_toggle)
	return {
        widget = wibox.widget.textclock,
        format = "<b>X</b>",
        font = "sans 12",
        halign = "right",
        buttons = {
            awful.button({}, 1, side_panel_toggle)
        }
	}
end

local function separator()
	return {
		widget = wibox.widget.separator,
		forced_height = dpi(16),
		forced_width = dpi(16),
	}
end

local function text_clock()
	return {
		widget = wibox.widget.textclock,
		format = "<b>%H:%M</b>",
		halign = "center",
		font = "sans 26",
	}
end

local function calendar()
	return {
		widget = wibox.container.place,
		valing = "center",
		{
			date = os.date("*t"),
			font = "sans 16",
			spacing = 5,
			week_numbers = false,
			start_sunday = false,
			widget = wibox.widget.calendar.month,
		},
	}
end

local _M = {
	side_panel = nil,
	popup_x = nil,
	popup_y = nil,
	popup_disabled_x = nil,
	is_active = false,
	panel_anim = nil,
}

_M.toggle = function()
	if _M.is_active == false then
		_M.is_active = true
		_M.panel_anim.target = _M.popup_x
	else
		_M.is_active = false
		_M.panel_anim.target = _M.popup_disabled_x
	end
end

-- TODO: Parametrize fonts, colors, etc
return function(screen)
	local topbar_height = dpi(32)
	local screen_width = screen.geometry.width
	local screen_height = screen.geometry.height

	local margin = dpi(24)
	local popup_height = (screen_height - topbar_height) - (margin * 2)
	local popup_width = dpi(312)

	_M.popup_x = screen_width - popup_width - margin
	_M.popup_disabled_x = _M.popup_x + 500
	_M.popup_y = topbar_height + margin

	_M.side_panel = awful.popup({
		widget = {
			widget = wibox.container.margin,
			margins = {
				top = dpi(10),
				left = dpi(10),
				right = dpi(10),
				bottom = dpi(10),
			},
            {
                layout = wibox.layout.fixed.vertical,
                spacing = dpi(8),
                close_button(_M.toggle),
			    {
                    layout = wibox.layout.fixed.vertical,
                    spacing = dpi(32),
                    text_clock(),
                    separator(),
                    calendar(),
                },
            }
		},
		minimum_width = popup_width,
		minimum_height = popup_height,
		maximum_height = popup_height,
		placement = false,
		ontop = true,
		x = _M.popup_disabled_x,
		y = _M.popup_y,
		shape = gears.shape.rounded_rect,
		screen = screen,
        visible = true,
	})

	_M.panel_anim = rubato.timed({
		duration = 0.5,
		pos = _M.popup_disabled_x,
		easing = rubato.easing.quadratic,
		subscribed = function(pos)
			_M.side_panel.x = pos
		end,
	})

	return _M
end
