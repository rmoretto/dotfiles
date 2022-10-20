local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato = require("modules.rubato")
local defaults = require("configs.defaults")

local function set_tag_indicator(c3, indicator, indicator_anim)
	if c3.selected then
		indicator.bg = "#ff0000"
		indicator_anim.target = dpi(32)
	elseif #c3:clients() == 0 then
		indicator.bg = "#00ff00"
		indicator_anim.target = dpi(16)
	else
		indicator.bg = "#0000ff"
		indicator_anim.target = dpi(16)
	end
end

local function tag_list(s)
    local modkey = defaults.modkey
	local taglist_buttons = gears.table.join(
		awful.button({}, 1, function(t)
			t:view_only()
		end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({}, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({}, 4, function(t)
			awful.tag.viewnext(t.screen)
		end),
		awful.button({}, 5, function(t)
			awful.tag.viewprev(t.screen)
		end)
	)

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			widget = wibox.container.margin,
			forced_width = dpi(40),
			-- forced_height = dpi(40),
			{
				widget = wibox.container.place,
				valing = "center",
				{
					id = "indicator",
					widget = wibox.container.background,
					shape = gears.shape.rounded_bar,
					{
						margins = dpi(6),
						widget = wibox.container.margin,
					},
				},
			},
			create_callback = function(self, c3, _) --luacheck: no unused args
				local indicator = self:get_children_by_id("indicator")[1]
				self.indicator_anim = rubato.timed({
					duration = 0.125,
					easing = rubato.easing.quadratic,
					subscribed = function(pos)
						indicator.forced_width = pos
					end,
				})

				set_tag_indicator(c3, indicator, self.indicator_anim)
			end,
			update_callback = function(self, c3, _) --luacheck: no unused args
				local indicator = self:get_children_by_id("indicator")[1]
				set_tag_indicator(c3, indicator, self.indicator_anim)
			end,
		},
		buttons = taglist_buttons,
	})

	local widget = wibox.widget({
		widget = wibox.container.margin,
		top = dpi(4),
		bottom = dpi(4),
		{
			widget = wibox.container.background,
			bg = "#777777",
			border_color = "#ffffff",
			border_width = 1,
			shape = gears.shape.rounded_bar,
			{
				widget = wibox.container.margin,
				margins = {
					left = dpi(16),
					right = dpi(16),
				},
				taglist,
			},
		},
	})

	return widget
end

local function task_list(s)
	local tasklist_buttons = gears.table.join(
		awful.button({}, 3, function()
			awful.menu.client_list({ theme = { width = 250 } })
		end),
		awful.button({}, 4, function()
			awful.client.focus.byidx(1)
		end),
		awful.button({}, 5, function()
			awful.client.focus.byidx(-1)
		end)
	)

	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.focused,
		buttons = tasklist_buttons,
		style = {
			font = "sans 12",
		},
		widget_template = {
			widget = wibox.container.margin,
			forced_width = dpi(256),
			top = dpi(4),
			bottom = dpi(4),
			{
				widget = wibox.container.background,
				shape = gears.shape.rounded_bar,
				bg = "#777777",
				border_color = "#ffffff",
				border_width = 1,
				{
					widget = wibox.container.place,
					haling = "center",
					{
						layout = wibox.layout.fixed.horizontal,
						{
							widget = wibox.container.margin,
							margins = 2,
							{
								id = "icon_role",
								widget = wibox.widget.imagebox,
							},
						},
						{
							id = "text_role",
							widget = wibox.widget.textbox,
							font = "sans 12",
						},
					},
				},
			},
		},
	})
end

local function side_panel_button(side_panel)
	return awful.widget.button({
		image = beautiful.awesome_icon,
		buttons = {
			awful.button({}, 1, nil, function()
				side_panel.toggle()
			end),
		},
	})
end

local function layout_box(screen)
	local layoutbox_buttons = gears.table.join(
		awful.button({}, 1, function(_)
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function(_)
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(1)
		end)
	)

	screen.mylayoutbox = awful.widget.layoutbox()
	screen.mylayoutbox:buttons(layoutbox_buttons)

	local widget = wibox.widget({
		widget = wibox.layout.fixed.horizontal,
		screen.mylayoutbox,
	})

	return widget
end

local function text_clock()
	return wibox.widget({
		widget = wibox.container.place,
		haling = "center",
		content_fill_vertical = true,
		{
			widget = wibox.container.margin,
			top = dpi(4),
			bottom = dpi(4),
			right = dpi(256),
			{
				widget = wibox.container.background,
				shape = gears.shape.rounded_bar,
				bg = "#777777",
				border_color = "#ffffff",
				border_width = 1,
				{
					widget = wibox.container.margin,
					left = dpi(8),
					right = dpi(8),
					{
						widget = wibox.widget.textclock,
						format = "%a, %d de %b - %H:%M",
						font = "sans 12",
					},
				},
			},
		},
	})
end

return function(screen, side_panel)
	awful.wibar({
		screen = screen,
		minimum_height = dpi(32),
		maximum_height = dpi(32),
		height = dpi(32),
		minimum_width = screen.geometry.width,
		maximum_width = screen.geometry.width,
		widget = {
			layout = wibox.layout.align.horizontal,
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(8),
				tag_list(screen),
				task_list(screen),
			},
			text_clock(),
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = dpi(8),
				wibox.widget.systray(),
				layout_box(screen),
				side_panel_button(side_panel),
			},
		},
	})
end
