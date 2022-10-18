local awful = require("awful")
local init_top_bar = require("ui.top_bar")
local init_side_panel = require("ui.side_panel")

local naughty = require("naughty")

naughty.connect_signal("request::display", function(notification)
    print("display", notification)
end)

naughty.connect_signal("request::display_error", function(notification)
    print("display_error", notification)
end)

naughty.connect_signal("request::icon", function(notification)
    print("icon", notification)
end)

naughty.connect_signal("request::action_icon", function(notification)
    print("action_icon", notification)
end)

naughty.connect_signal("added", function(notification)
    print("added", notification)
end)

awful.screen.connect_for_each_screen(function(s)
    local side_panel = init_side_panel(s)
	init_top_bar(s, side_panel)
end)
