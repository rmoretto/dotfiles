local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local rubato = require("modules.rubato")

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

local function set_indicator(c3, indicator, indicator_anim)
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

return function(s)
	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			widget = wibox.container.margin,
			forced_width = dpi(40),
			forced_height = dpi(40),
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

				set_indicator(c3, indicator, self.indicator_anim)
			end,
			update_callback = function(self, c3, _) --luacheck: no unused args
				local indicator = self:get_children_by_id("indicator")[1]
				set_indicator(c3, indicator, self.indicator_anim)
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

	-- local widget = widgets.button.elevated.state({
	--     normal_bg = beautiful.widget_bg,
	--     normal_shape = gears.shape.rounded_bar,
	--     child = {
	--         taglist,
	--         margins = { left = dpi(10), right = dpi(10) },
	--         widget = wibox.container.margin,
	--     },
	--     on_release = function()
	--         awesome.emit_signal("central_panel::toggle", s)
	--     end,
	-- })

	-- return wibox.widget({
	--     -- widget,
	--     taglist,
	--     margins = dpi(5),
	--     widget = wibox.container.margin,
	-- })

	return widget
end
