local HOME = vim.fn.expand("$HOME")
local opt = vim.opt

vim.g.mapleader = "\\"

opt.encoding = "UTF-8"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.updatetime = 50
opt.foldlevelstart = 20

opt.hidden = true
opt.relativenumber = true
opt.errorbells = false
opt.expandtab = true
opt.smartindent = true
opt.nu = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.incsearch = true
opt.showmode = false
opt.title = true

opt.timeoutlen = 1000
opt.ttimeoutlen = 0
opt.undodir = HOME .. "/.vim/undodir"
opt.mouse = "a"

-- integration works automatically. Requires Neovim >= 0.10.0
opt.completeopt = "menu,menuone,noselect"
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.splitkeep = "screen"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.termguicolors = true -- True color support
opt.undolevels = 10000
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width

opt.smoothscroll = true
opt.foldmethod = "expr"
opt.foldtext = ""
vim.g.markdown_recommended_style = 0
