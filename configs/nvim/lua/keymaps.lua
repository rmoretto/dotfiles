local utils = require("utils")

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Yes
keymap.set("n", "<F12>", utils.reload_nvim, opts)

-- OS copy-paste
keymap.set("n", "<Leader>y", "\"+y", opts)
keymap.set("v", "<Leader>y", "\"+y", opts)

-- Move lines
keymap.set("n", "<C-A-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<C-A-k>", ":m .-2<CR>==", opts)
keymap.set("i", "<C-A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("i", "<C-A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("v", "<C-A-j>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-A-k>", ":m '<-2<CR>gv=gv", opts)

keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

keymap.set("n", "<Leader><CR>", ":noh<cr>", opts)
keymap.set("n", "<Leader><CR>", ":let @/ = \"\"<cr>", opts)

-- Copy 'til the end of line
keymap.set("n", "Y", "yg_", opts)

-- Better search jump
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Maintain the cursor on BIG J
keymap.set("n", "J", "mzJ`z", opts)

-- Undo break points BIG COCONUT OIL
keymap.set("i", "\"", "\"<c-g>u", opts)
keymap.set("i", "'", "'<c-g>u", opts)
keymap.set("i", ",", ",<c-g>u", opts)
keymap.set("i", ".", ".<c-g>u", opts)
keymap.set("i", ":", ":<c-g>u", opts)
keymap.set("i", ";", ";<c-g>u", opts)
keymap.set("i", "!", "!<c-g>u", opts)
keymap.set("i", "?", "?<c-g>u", opts)
keymap.set("i", "(", "(<c-g>u", opts)
keymap.set("i", ")", ")<c-g>u", opts)
keymap.set("i", "[", "[<c-g>u", opts)
keymap.set("i", "]", "]<c-g>u", opts)
keymap.set("i", "{", "{<c-g>u", opts)
keymap.set("i", "}", "}<c-g>u", opts)
keymap.set("i", "-", "-<c-g>u", opts)

-- Close quickfix
keymap.set("n", "<leader>x", ":ccl <CR>", opts)

-- Search and replace
keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>", opts)

-- Search for selected text, forwards or backwards.
-- Ref: https://vim.fandom.com/wiki/Search_for_visually_selected_text
keymap.set("v", "*", [[ :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
]], opts)

keymap.set("v", "#", [[ :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
]], opts)
