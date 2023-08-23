local dap = require("dap")
local utils = require("utils")

dap.adapters.mix_task = {
	type = "executable",
	command = "elixir-debugger.sh",
	args = {},
}

dap.configurations.elixir = {
	{
		type = "mix_task",
		name = "mix test",
		task = "test",
		taskArgs = function()
      local linenum = vim.api.nvim_win_get_cursor(0)[1]
      local test_file = "${relativeFile}:" .. linenum
      utils.inspect(test_file)
      return { "--trace", test_file }
    end,
		request = "launch",
		projectDir = "${workspaceFolder}",
    startApp = true,
		env = {
			MIX_ENV = "test",
		},
		requireFiles = {
      -- "test/test_helper.exs",
      -- "${relativeFile}"
    },
    excludeModules = {
      "Jsonrs",
      "Qrusty.Native",
      "ChromicPDF",
      "Argon2"
    }
	},
  {
		type = "mix_task",
		name = "phx debugger",
		task = "phx.server",
		taskArgs = {},
		request = "launch",
		projectDir = "${workspaceFolder}",
    startApp = false,
		env = {
			MIX_ENV = "dev",
		},
    excludeModules = {
      "Jsonrs",
      "Qrusty.Native",
      "ChromicPDF",
      "Argon2"
    }
	},
}

vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>b", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>B", function()
	require("dap").set_breakpoint()
end)
vim.keymap.set("n", "<Leader>lp", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<Leader>dr", function()
	require("dap").repl.open()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end)
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
