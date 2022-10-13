local dpi = require("beautiful.xresources").apply_dpi

return {
    apps = {
        terminal = "alacritty",
        screenshot = "flameshot gui",
    },
    client = {
        resize = {
            floating_amount = dpi(20),
            tilling_amount = 0.05,
        }
    }
}
