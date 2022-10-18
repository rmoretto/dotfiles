local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local styles = {}

local function rounded_shape(size, partial)
	if partial then
		return function(cr, width, height)
			gears.shape.partially_rounded_rect(cr, width, height, false, true, false, true, 5)
		end
	else
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, size)
		end
	end
end

styles.month = { padding = 5, bg_color = "#555555", border_width = 2, shape = rounded_shape(10) }
styles.normal = { shape = rounded_shape(5) }
styles.focus = {
	fg_color = "#000000",
	bg_color = "#ff9800",
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
	shape = rounded_shape(5, true),
}
styles.header = {
	fg_color = "#de5e1e",
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
	shape = rounded_shape(10),
}
styles.weekday = {
	fg_color = "#7788af",
	markup = function(t)
		return "<b>" .. t .. "</b>"
	end,
	shape = rounded_shape(5),
}

local function decorate_cell(widget, flag, date)
	if flag == "monthheader" and not styles.monthheader then
		flag = "header"
	end
	local props = styles[flag] or {}
	if props.markup and widget.get_text and widget.set_markup then
		widget:set_markup(props.markup(widget:get_text()))
	end
	-- Change bg color for weekends
	local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
	local weekday = tonumber(os.date("%w", os.time(d)))
	local default_bg = (weekday == 0 or weekday == 6) and "#232323" or "#383838"
	local ret = wibox.widget({
		{
			widget,
			margins = (props.padding or 2) + (props.border_width or 0),
			widget = wibox.container.margin,
		},
		shape = props.shape,
		border_color = props.border_color or "#b9214f",
		border_width = props.border_width or 0,
		fg = props.fg_color or "#999999",
		bg = props.bg_color or default_bg,
		widget = wibox.container.background,
	})
	return ret
end

local function init()
	local calendar_widget = wibox.widget({
		date = os.date("*t"),
		font = "sans 16",
		spacing = 5,
		week_numbers = false,
		start_sunday = false,
		fn_embed = decorate_cell,
		widget = wibox.widget.calendar.month,
	})

	local widget = wibox.widget({
		widget = wibox.container.place,
		valing = "center",
		calendar_widget,
	})

	calendar_widget:buttons(gears.table.join(
		awful.button({}, 4, function()
			local a = calendar_widget:get_date()
			a.month = a.month + 1
			calendar_widget:set_date(nil)
			calendar_widget:set_date(a)
		end),
		awful.button({}, 5, function()
			local a = calendar_widget:get_date()
			a.month = a.month - 1
			calendar_widget:set_date(nil)
			calendar_widget:set_date(a)
		end)
	))

	return widget
end

return init
