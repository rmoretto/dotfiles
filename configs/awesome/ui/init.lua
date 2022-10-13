local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local top_bar = require("ui.top_bar")

local function loco(s)
    awful.popup({
        screen = s,
        type = "dock",
        maximum_height = dpi(32),
        minimum_width = s.geometry.width,
        maximum_width = s.geometry.width,
        placement = function(c)
            awful.placement.top(c)
        end,
        bg = beautiful.transparent,
        widget = {
            {
                {
                    layout = wibox.layout.align.horizontal,
                    expand = "none",
                    top_bar(s),
                },
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin,
            },
            bg = beautiful.wibar_bg,
            widget = wibox.container.background,
            forced_height = dpi(74),
        },
    })

    -- s.mywibox = awful.wibar {
    --     position = "top",
    --     screen = s,
    --     widget = {
    --         layout = wibox.layout.align.horizontal,
    --         {
    --             {
    --                 layout = wibox.layout.fixed.horizontal,
    --                 spacing = 5,
    --                 top_bar(s),
    --             },
    --             widget = wibox.container.margin,
    --             margins = 3
    --         }
    --     }
    -- }
end

awful.screen.connect_for_each_screen(function(s)
	--- Panels
	loco(s)
end)
