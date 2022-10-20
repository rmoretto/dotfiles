local dpi = require("beautiful.xresources").apply_dpi

return {
    modkey = "Mod4",
	apps = {
		terminal = "alacritty",
		screenshot = "flameshot gui",
		rofi = "rofi -modi drun,run,window,ssh -show drun -show-icons -drun-icon-theme -lines 20 -padding 25 -width 30 -columns 1",
	},
	client = {
		resize = {
			floating_amount = dpi(20),
			tilling_amount = 0.05,
		},
	},
}
