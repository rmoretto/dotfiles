local awful = require("awful")
local bling = require("modules.bling")
local hotkeys_popup = require("awful.hotkeys_popup")
local defaults = require("configs.defaults")
local scratchpad = require("configs.scratchpad")
local volume = require("ui.widgets.volume")

local mod = "Mod4"
local alt = "Mod1"
local ctrl = "Control"
local shift = "Shift"
local enter = "Return"

-- -------------------
-- -- Helpers Functions
local key = awful.key
local toggle_float = awful.client.floating.toggle

local function spawn_term()
	awful.spawn(defaults.apps.terminal)
end

local function spawn_rofi()
	awful.spawn(defaults.apps.rofi)
end

local function take_screenshot()
	awful.spawn.easy_async_with_shell(defaults.apps.screenshot)
end

local function is_floating(c)
	return (c and c.floating) or awful.layout.get(mouse.screen) == awful.layout.suit.floating
end

local function is_tilling()
	return awful.layout.get(mouse.screen) ~= awful.layout.suit.floating
end

local function toggle_fullscreen()
	client.focus.fullscreen = not client.focus.fullscreen
	client.focus:raise()
end

-- Client Focus
local function change_focus(dir)
	awful.client.focus.bydirection(dir)
	bling.module.flash_focus.flashfocus(client.focus)
end

local focus = {
	up = function()
		change_focus("up")
	end,
	down = function()
		change_focus("down")
	end,
	left = function()
		change_focus("left")
	end,
	right = function()
		change_focus("right")
	end,
}

-- Client resize
local function _resize_floating(c, dir)
	local resize_amount = defaults.client.resize.floating_amount
	if dir == "up" then
		c:relative_move(0, 0, 0, -resize_amount)
	elseif dir == "down" then
		c:relative_move(0, 0, 0, resize_amount)
	elseif dir == "left" then
		c:relative_move(0, 0, -resize_amount, 0)
	elseif dir == "right" then
		c:relative_move(0, 0, resize_amount, 0)
	end
end

local function _resize_tilling(dir)
	local resize_amount = defaults.client.resize.tilling_amount
	if dir == "up" then
		awful.client.incwfact(-resize_amount)
	elseif dir == "down" then
		awful.client.incwfact(resize_amount)
	elseif dir == "left" then
		awful.tag.incmwfact(-resize_amount)
	elseif dir == "right" then
		awful.tag.incmwfact(resize_amount)
	end
end

local function resize_client(dir)
	local c_focus = client.focus
	local floating = is_floating(c_focus)
	local tilling = is_tilling()

	if floating then
		_resize_floating(c_focus, dir)
	elseif tilling then
		_resize_tilling(dir)
	end
end

local resize = {
	up = function()
		resize_client("up")
	end,
	down = function()
		resize_client("down")
	end,
	left = function()
		resize_client("left")
	end,
	right = function()
		resize_client("right")
	end,
}

-- Client Move
local function move_client(c, dir)
	-- local is_floating = is_floating(c)
	local tilling = is_tilling()

	if tilling then
		if dir == "up" or dir == "left" then
			awful.client.swap.byidx(-1, c)
		elseif dir == "down" or dir == "right" then
			awful.client.swap.byidx(1, c)
		end
	end
end

local move = {
	up = function(c)
		move_client(c, "up")
	end,
	down = function(c)
		move_client(c, "down")
	end,
	left = function(c)
		move_client(c, "left")
	end,
	right = function(c)
		move_client(c, "right")
	end,
}

-- Tags
local function _get_tag_by_idx(idx)
	local screen = awful.screen.focused()
	return screen.tags[idx]
end

local function view_tag(index)
	local tag = _get_tag_by_idx(index)
	if tag then
		tag:view_only()
	end
end

local function toggle_tag(index)
	local tag = _get_tag_by_idx(index)
	if tag then
		awful.tag.viewtoggle(tag)
	end
end

local function move_client_to_tag(index)
	local c_focus = client.focus
	if c_focus then
		local tag = c_focus.screen.tags[index]
		if tag then
			c_focus:move_to_tag(tag)
		end
	end
end

local function close_client()
	local c_focus = client.focus
	if c_focus then
		c_focus:kill()
	end
end

-- Layout
local function next_layout()
	awful.layout.inc(1)
end

local function last_layout()
	awful.layout.inc(1)
end

-- -------------------
-- -- Global Keybings
local global_keys = {
	-- ----
	-- Spawner
	-- Open terminal
	key({ mod }, enter, spawn_term, { description = "open terminal", group = "app" }),
	key({ mod }, "d", spawn_rofi, { description = "open rofi", group = "app" }),

	-- Hotkeys
	-- Open terminal
	key({}, "Print", take_screenshot, { description = "take screenshot", group = "hotkey" }),
	-- Volume
	key({ mod }, "XF86AudioRaiseVolume", function()
		volume:inc()
	end, { description = "inc volume", group = "hotkey" }),
	key({ mod }, "XF86AudioLowerVolume", function()
		volume:dec()
	end, { description = "dec volume", group = "hotkey" }),

	-- ----
	-- WM
	-- Restart Awesome
	key({ mod, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "WM" }),
	-- Show Help
	key({ mod }, "F1", hotkeys_popup.show_help, { description = "show help", group = "WM" }),

	-- ----
	-- Client
	-- Change Focus
	key({ mod }, "i", focus.up, { description = "focus up", group = "client" }),
	key({ mod }, "k", focus.down, { description = "focus down", group = "client" }),
	key({ mod }, "j", focus.left, { description = "focus left", group = "client" }),
	key({ mod }, "l", focus.right, { description = "focus right", group = "client" }),
	-- Resize
	key({ mod, ctrl }, "i", resize.up, { description = "resize up", group = "client" }),
	key({ mod, ctrl }, "k", resize.down, { description = "resize down", group = "client" }),
	key({ mod, ctrl }, "j", resize.left, { description = "resize left", group = "client" }),
	key({ mod, ctrl }, "l", resize.right, { description = "resize right", group = "client" }),
	-- Move
	key({ mod, shift }, "i", move.up, { description = "move up", group = "client" }),
	key({ mod, shift }, "k", move.down, { description = "move down", group = "client" }),
	key({ mod, shift }, "j", move.left, { description = "move left", group = "client" }),
	key({ mod, shift }, "l", move.right, { description = "move right", group = "client" }),
	-- Close client
	key({ mod, shift }, "q", close_client, { description = "close a client", group = "client" }),
	-- Toggle floating
	key({ mod, ctrl }, "space", toggle_float, { description = "toggle floating", group = "client" }),
	-- Toggle fullscreen
	key({ mod }, "f", toggle_fullscreen, { description = "toggle fullscreen", group = "client" }),

	-- ----
	-- Layout
	-- Change Layout
	key({ mod }, "space", next_layout, { description = "select next layout", group = "layout" }),
	key({ mod, shift }, "space", last_layout, { description = "select previous layout", group = "layout" }),

	-- ----
	-- Workspaces
	-- Toggle Tag
	key({
		modifiers = { mod },
		keygroup = awful.key.keygroup.NUMROW,
		description = "only view tag",
		group = "tag",
		on_press = view_tag,
	}),
	key({
		modifiers = { mod, ctrl },
		keygroup = awful.key.keygroup.NUMROW,
		description = "toggle tag",
		group = "tag",
		on_press = toggle_tag,
	}),
	key({
		modifiers = { mod, shift },
		keygroup = awful.key.keygroup.NUMROW,
		description = "move client to tag",
		group = "tag",
		on_press = move_client_to_tag,
	}),

	-- ----
	-- Scratchpad
	-- Term test
	-- key({ mod, "p" }, "s", scratchpad.toggle_terminal, { description = "toggle terminal", group = "scratchpad" })
	key({ mod, alt }, "s", scratchpad.toggle_spotify, { description = "toggle spotify", group = "scratchpad" }),
}

-- root.keys(global_keys)
awful.keyboard.append_global_keybindings(global_keys)

-- -------------------
-- -- Mouse on client
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ mod }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ mod }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)

-- {{{ Key bindings
-- globalkeys = gears.table.join(
--     awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
--     awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
--     awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
--  o  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
--
--     awful.key({ modkey }, "j", function()
--         awful.client.focus.byidx(1)
--     end, { description = "focus next by index", group = "client" }),
--     awful.key({ modkey }, "k", function()
--         awful.client.focus.byidx(-1)
--     end, { description = "focus previous by index", group = "client" }),
--     awful.key({ modkey }, "w", function()
--         mymainmenu:show()
--     end, { description = "show main menu", group = "awesome" }),
--
--     -- Layout manipulation
--     awful.key({ modkey, "Shift" }, "j", function()
--         awful.client.swap.byidx(1)
--     end, { description = "swap with next client by index", group = "client" }),
--     awful.key({ modkey, "Shift" }, "k", function()
--         awful.client.swap.byidx(-1)
--     end, { description = "swap with previous client by index", group = "client" }),
--     awful.key({ modkey, "Control" }, "j", function()
--         awful.screen.focus_relative(1)
--     end, { description = "focus the next screen", group = "screen" }),
--     awful.key({ modkey, "Control" }, "k", function()
--         awful.screen.focus_relative(-1)
--     end, { description = "focus the previous screen", group = "screen" }),
--     awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
--     awful.key({ modkey }, "Tab", function()
--         awful.client.focus.history.previous()
--         if client.focus then
--             client.focus:raise()
--         end
--     end, { description = "go back", group = "client" }),
--
--     -- Standard program
--     awful.key({ modkey }, "Return", function()
--         awful.spawn(terminal)
--     end, { description = "open a terminal", group = "launcher" }),
--     awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
--     awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
--
--     awful.key({ modkey }, "l", function()
--         awful.tag.incmwfact(0.05)
--     end, { description = "increase master width factor", group = "layout" }),
--     awful.key({ modkey }, "h", function()
--         awful.tag.incmwfact(-0.05)
--     end, { description = "decrease master width factor", group = "layout" }),
--     awful.key({ modkey, "Shift" }, "h", function()
--         awful.tag.incnmaster(1, nil, true)
--     end, { description = "increase the number of master clients", group = "layout" }),
--     awful.key({ modkey, "Shift" }, "l", function()
--         awful.tag.incnmaster(-1, nil, true)
--     end, { description = "decrease the number of master clients", group = "layout" }),
--     awful.key({ modkey, "Control" }, "h", function()
--         awful.tag.incncol(1, nil, true)
--     end, { description = "increase the number of columns", group = "layout" }),
--     awful.key({ modkey, "Control" }, "l", function()
--         awful.tag.incncol(-1, nil, true)
--     end, { description = "decrease the number of columns", group = "layout" }),
--     awful.key({ modkey }, "space", function()
--         awful.layout.inc(1)
--     end, { description = "select next", group = "layout" }),
--     awful.key({ modkey, "Shift" }, "space", function()
--         awful.layout.inc(-1)
--     end, { description = "select previous", group = "layout" }),
--
--     awful.key({ modkey, "Control" }, "n", function()
--         local c = awful.client.restore()
--         -- Focus restored client
--         if c then
--             c:emit_signal("request::activate", "key.unminimize", { raise = true })
--         end
--     end, { description = "restore minimized", group = "client" }),
--
--     -- Prompt
--     awful.key({ modkey }, "r", function()
--         awful.screen.focused().mypromptbox:run()
--     end, { description = "run prompt", group = "launcher" }),
--
--     awful.key({ modkey }, "x", function()
--         awful.prompt.run({
--             prompt = "Run Lua code: ",
--             textbox = awful.screen.focused().mypromptbox.widget,
--             exe_callback = awful.util.eval,
--             history_path = awful.util.get_cache_dir() .. "/history_eval",
--         })
--     end, { description = "lua execute prompt", group = "awesome" }),
--     -- Menubar
--     awful.key({ modkey }, "p", function()
--         menubar.show()
--     end, { description = "show the menubar", group = "launcher" })
-- )
--
-- clientkeys = gears.table.join(
--     awful.key({ modkey }, "f", function(c)
--         c.fullscreen = not c.fullscreen
--         c:raise()
--     end, { description = "toggle fullscreen", group = "client" }),
--     awful.key({ modkey, "Shift" }, "c", function(c)
--         c:kill()
--     end, { description = "close", group = "client" }),
--     awful.key(
--         { modkey, "Control" },
--         "space",
--         awful.client.floating.toggle,
--         { description = "toggle floating", group = "client" }
--     ),
--     awful.key({ modkey, "Control" }, "Return", function(c)
--         c:swap(awful.client.getmaster())
--     end, { description = "move to master", group = "client" }),
--     awful.key({ modkey }, "o", function(c)
--         c:move_to_screen()
--     end, { description = "move to screen", group = "client" }),
--     awful.key({ modkey }, "t", function(c)
--         c.ontop = not c.ontop
--     end, { description = "toggle keep on top", group = "client" }),
--     awful.key({ modkey }, "n", function(c)
--         -- The client currently has the input focus, so it cannot be
--         -- minimized, since minimized clients can't have the focus.
--         c.minimized = true
--     end, { description = "minimize", group = "client" }),
--     awful.key({ modkey }, "m", function(c)
--         c.maximized = not c.maximized
--         c:raise()
--     end, { description = "(un)maximize", group = "client" }),
--     awful.key({ modkey, "Control" }, "m", function(c)
--         c.maximized_vertical = not c.maximized_vertical
--         c:raise()
--     end, { description = "(un)maximize vertically", group = "client" }),
--     awful.key({ modkey, "Shift" }, "m", function(c)
--         c.maximized_horizontal = not c.maximized_horizontal
--         c:raise()
--     end, { description = "(un)maximize horizontally", group = "client" })
-- )
--
-- -- Bind all key numbers to tags.
-- -- Be careful: we use keycodes to make it work on any keyboard layout.
-- -- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
--     globalkeys = gears.table.join(
--         globalkeys,
--         -- View tag only.
--         awful.key({ modkey }, "#" .. i + 9, function()
--             local screen = awful.screen.focused()
--             local tag = screen.tags[i]
--             if tag then
--                 tag:view_only()
--             end
--         end, { description = "view tag #" .. i, group = "tag" }),
--         -- Toggle tag display.
--         awful.key({ modkey, "Control" }, "#" .. i + 9, function()
--             local screen = awful.screen.focused()
--             local tag = screen.tags[i]
--             if tag then
--                 awful.tag.viewtoggle(tag)
--             end
--         end, { description = "toggle tag #" .. i, group = "tag" }),
--         -- Move client to tag.
--         awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
--             if client.focus then
--                 local tag = client.focus.screen.tags[i]
--                 if tag then
--                     client.focus:move_to_tag(tag)
--                 end
--             end
--         end, { description = "move focused client to tag #" .. i, group = "tag" }),
--         -- Toggle tag on focused client.
--         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
--             if client.focus then
--                 local tag = client.focus.screen.tags[i]
--                 if tag then
--                     client.focus:toggle_tag(tag)
--                 end
--             end
--         end, { description = "toggle focused client on tag #" .. i, group = "tag" })
--     )
-- end
