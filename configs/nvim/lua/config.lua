vim.cmd([[ 
    syntax on 

    let g:loaded_netrw       = 1
    let g:loaded_netrwPlugin = 1

    autocmd BufEnter *.nomad set filetype=hcl

    autocmd FileType elixir setlocal ts=2 sts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2
    autocmd FileType typescript setlocal ts=2 sts=2 sw=2
    autocmd FileType vue setlocal ts=2 sts=2 sw=2
    autocmd FileType html setlocal ts=2 sts=2 sw=2
    autocmd FileType css setlocal ts=2 sts=2 sw=2
    autocmd FileType scss setlocal ts=2 sts=2 sw=2
    autocmd FileType scss setl iskeyword+=@-@
    autocmd FileType dart setlocal ts=2 sts=2 sw=2
    autocmd FileType hcl setlocal ts=2 sts=2 sw=2
    autocmd FileType terraform setlocal ts=2 sts=2 sw=2
    autocmd FileType json setlocal ts=2 sts=2 sw=2
    autocmd FileType lua setlocal ts=2 sts=2 sw=2
    autocmd FileType nix setlocal ts=2 sts=2 sw=2

    " Triger `autoread` when files changes on disk
    " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
    " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

    " Notification after file change
    " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
    autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

    autocmd BufEnter * :call SetFiletypeNewBuffer()
    function! SetFiletypeNewBuffer()
      if @% == ""
        :set filetype=none
      endif
    endfunction
]])

local HOME = vim.fn.expand("$HOME")
vim.g.mapleader = "\\"

vim.o.encoding = "UTF-8"
-- vim.o.pastetoggle = "<F3>"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.updatetime = 50
vim.o.foldlevelstart = 20
vim.o.cmdheight = 0

vim.o.hidden = true
vim.o.relativenumber = true
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.nu = true
vim.o.wrap = false
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.incsearch = true
vim.o.showmode = false
vim.o.title = true

vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 0
vim.o.undodir = HOME .. "/.vim/undodir"
vim.o.completeopt = "menuone,noinsert,noselect"
-- vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.mouse = "a"

-- Setup color scheme
-- vim.cmd("colorscheme kanagawa")
