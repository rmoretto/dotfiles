local keymap = vim.keymap

require("trouble").setup {}

local opts = { noremap = true, silent = true }
keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap.set("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", opts)
keymap.set("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>", opts)
keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)
