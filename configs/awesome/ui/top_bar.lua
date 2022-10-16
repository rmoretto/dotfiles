local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato = require("modules.rubato")

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
		widget = wibox.container.background,
		bg = "#ffffff",
		shape = gears.shape.rounded_bar,
		{
			widget = wibox.container.margin,
			margins = {
				left = dpi(32),
				right = dpi(32),
			},
			taglist,
		},
	})

	return widget
end

local function task_list(s)
	local tasklist_buttons = gears.table.join(
		awful.button({}, 1, function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end),
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

	awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
		style = {
			border_width = 1,
			border_color = "#777777",
			shape = gears.shape.rounded_bar,
		},
		layout = {
			spacing = 10,
			spacing_widget = {
				{
					forced_width = 5,
					shape = gears.shape.circle,
					widget = wibox.widget.separator,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout = wibox.layout.flex.horizontal,
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget = wibox.container.margin,
					},
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 10,
				right = 10,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
	})
end

local function side_panel_button(side_panel)
    return awful.widget.button({
        image = beautiful.awesome_icon,
        buttons = {
            awful.button({}, 1, nil, function ()
                side_panel.toggle()
            end)
        }
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
		-- type = "dock",
		-- placement = function(c)
		--     awful.placement.top(c)
		-- end,
		-- bg = beautiful.transparent,
		widget = {
			{
				{
					layout = wibox.layout.align.horizontal,
					expand = "none",
					tag_list(screen),
					task_list(screen),
                    side_panel_button(side_panel)
				},
				left = dpi(10),
				right = dpi(10),
				widget = wibox.container.margin,
			},
			bg = beautiful.wibar_bg,
			widget = wibox.container.background,
		},
	})
end
