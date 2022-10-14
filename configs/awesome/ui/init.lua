local awful = require("awful")
local init_top_bar = require("ui.top_bar")
local init_side_panel = require("ui.side_panel")

awful.screen.connect_for_each_screen(function(s)
    local side_panel = init_side_panel(s)
	init_top_bar(s, side_panel)
end)
