local gears = require("gears")

require("configs.tags")
require("configs.keybindigs")
require("configs.layouts")

client.connect_signal("manage", function(c) c.shape = gears.shape.rounded_rect end)
