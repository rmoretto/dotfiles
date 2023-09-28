-- local keymap = vim.keymap
-- local neotest = require("neotest")
-- 
-- neotest.setup({
--   adapters = {
--     require("neotest-elixir")({}),
--     require("neotest-rust"),
--   },
--   quickfix = {
--     enabled = false,
--     open = false,
--   },
--   summary = {
--     open = "botright vsplit | vertical resize 80",
--   },
-- })
-- 
-- local function test_file()
--   neotest.run.run(vim.fn.expand("%"))
-- end
-- 
-- local function test_suite()
--   neotest.run.run(vim.fn.getcwd())
-- end
-- 
-- local opts = { noremap = true, silent = true }
-- 
-- keymap.set("n", "t<C-n>", neotest.run.run, opts)
-- keymap.set("n", "t<C-f>", test_file, opts)
-- keymap.set("n", "t<C-s>", test_suite, opts)
-- keymap.set("n", "t<C-l>", neotest.run.run_last, opts)
-- keymap.set("n", "t<C-l>", neotest.run.run_last, opts)
-- keymap.set("n", "to", neotest.output.open, opts)
-- keymap.set("n", "tw", neotest.output_panel.toggle, opts)
-- keymap.set("n", "tq", neotest.summary.toggle, opts)

-- keymap.set("n", "t<C-n>", ":TestNearest<CR>", opts)
-- keymap.set("n", "t<C-f>", ":TestFile<CR>", opts)
-- keymap.set("n", "t<C-s>", ":TestSuite<CR>", opts)
-- keymap.set("n", "t<C-l>", ":TestLast<CR>", opts)
-- keymap.set("n", "t<C-g>", ":TestVisit<CR>", opts)