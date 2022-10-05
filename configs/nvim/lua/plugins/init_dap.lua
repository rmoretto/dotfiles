local dap = require("dap")

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
		taskArgs = { "--trace" },
		request = "launch",
		startApps = true,
		projectDir = "${workspaceFolder}",
		env = {
			MIX_ENV = "test",
		},
		-- requireFiles = {
		--   "test/**/test_helper.exs",
		--   "test/**/*_test.exs"
		-- }
	},
}
