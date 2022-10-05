local keymap = vim.keymap

vim.g.rnvimr_draw_border = 1
vim.g.rnvimr_ranger_cmd = { "ranger", '--cmd="set draw_borders both"' }
vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_hide_gitignore = 0
vim.g.rnvimr_enable_bw = 1

local opts = { noremap = true, silent = true }
keymap.set("t", "<M-i>", "<C-\\><C-n>:RnvimrResize<CR>", opts)
keymap.set("n", "<A-q>", ":RnvimrToggle<CR>", opts)
keymap.set("t", "<A-q>", "<C-\\><C-n>:RnvimrToggle<CR>", opts)
