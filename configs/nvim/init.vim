" --------------------------------------------
" ----------- Native Configurations ----------
" --------------------------------------------
syntax on

let mapleader = "\\"

set encoding=UTF-8
set pastetoggle=<F3>
set hidden
set timeoutlen=1000 ttimeoutlen=0
set relativenumber
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set noshowmode
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set cmdheight=2
set updatetime=50
set title
set mouse=a
set foldlevelstart=20

let g:loaded_netrw= 1 
let g:netrw_loaded_netrwPlugin= 1

autocmd FileType elixir setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType vue setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType scss setlocal ts=2 sts=2 sw=2
autocmd FileType dart setlocal ts=2 sts=2 sw=2

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None



" --------------------------------------------
" ------------ Plug Configurations -----------
" --------------------------------------------
call plug#begin('~/.vim/plugged')

" Colorshemes
Plug 'https://github.com/sainnhe/sonokai'

" Icons because yes
Plug 'kyazdani42/nvim-web-devicons'
Plug 'https://github.com/ryanoasis/vim-devicons'

" Vim Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Vim Ranger
Plug 'https://github.com/kevinhwang91/rnvimr'

" Git Stuffs 
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" The one and only tpoe
Plug 'https://github.com/tpope/vim-dispatch'

" Windows Helpers
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'edkolev/tmuxline.vim'
Plug 'https://github.com/mhinz/vim-startify'
Plug 'https://github.com/simeji/winresizer'
Plug 'beauwilliams/focus.nvim' , {'branch': 'master'}

" Misc
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'ggandor/lightspeed.nvim'
Plug 'https://github.com/vim-test/vim-test'
Plug 'https://github.com/raimondi/delimitmate'
Plug 'tommcdo/vim-exchange'
Plug 'nvim-treesitter/playground'

" IDE Like 
Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'tami5/lspsaga.nvim'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mhartington/formatter.nvim'
Plug 'folke/trouble.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'RRethy/vim-illuminate'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'elixir-editors/vim-elixir'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-emoji'

" Plug 'hrsh7th/nvim-compe'
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

call plug#end()

" --------------------------------------------
" ------------ Base Configurations -----------
" --------------------------------------------
" ------- Themes
if has('termguicolors')
    set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

" Override TS Colors
highlight! link TSSymbol OrangeItalic
highlight! link TSStringEscape Purple

" -------------- General Keymaps
nnoremap <F12> :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Maintain visual mode after ident
vnoremap < <gv
vnoremap > >gv

nnoremap <Leader><CR> :noh<cr>
nnoremap <Leader><CR> :let @/ = ""<cr>

" Copy 'til the end of line
nnoremap Y yg_

" Better search jump
nnoremap n nzzzv
nnoremap N Nzzzv

" Maintain the cursor on BIG J
nnoremap J mzJ`z

" Undo break points BIG COCONUT OIL
inoremap " "<c-g>u
inoremap ' '<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap ( (<c-g>u
inoremap ) )<c-g>u
inoremap [ [<c-g>u
inoremap ] ]<c-g>u
inoremap { {<c-g>u
inoremap } }<c-g>u
inoremap - -<c-g>u

" Quick fix Key maps
nnoremap <silent> <leader>x :ccl <CR>
nnoremap <silent> <leader>z :cexpr system('git grep --line-number -e PERFORMANCE -e FIXME -e TODO') <CR> :botright copen <CR>

" Search and replace selected text
" Reference: https://stackoverflow.com/a/676619/10106533
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" New map to start and of line
"nnoremap <silent> <C-i> :normal ^<CR>
"nnoremap <silent> <C-a> :normal $<CR>
"
" Search for selected text, forwards or backwards.
" Ref: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" -------------- Yank highlight
function HighlightYank()
    execute 'IlluminationDisable'
    lua vim.highlight.on_yank{higroup="DiffAdd", timeout=300} 

    timer_start(300, 'IlluminationEnable', {'repeat': 1})
endfunction

" let g:Illuminate_highlightPriority = 100

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! call HighlightYank()
    " au TextYankPost * silent! :IlluminateDisable<CR> lua vim.highlight.on_yank{higroup="DiffAdd", timeout=300} IlluminateEnable<CR>
augroup END

" -------------- Load Environment variables to Vim runtime
function! s:env(var) abort
  return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

function! Env()
    redir => s
    sil! exe "norm!:ec$\<c-a>'\<c-b>\<right>\<right>\<del>'\<cr>"
    redir END
    return split(s)
endfunction

autocmd FileType scss setl iskeyword+=@-@

" --------------------------------------------
" ---------- Plugins Configurations ----------
" --------------------------------------------

" -------------- Telescop Config
"autocmd VimEnter * Telescope find_files
function! MaybeTelescope()
    if argc() == 1 && isdirectory(argv()[0])
        " Uncomment this to remove the Netrw buffer (optional)
        " execute "bdelete"
        execute "Telescope find_files"
    endif
endfunction

autocmd VimEnter * :call MaybeTelescope()

lua require("telescope_conf")

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fp <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" -------------- LSP Config
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<CR>
lua require("lsp")

nnoremap <C-A-o> <cmd>lua vim.lsp.buf.code_action({only = {"source.organizeImports"}})<CR>

" -------------- Focus Config
lua require("focus").setup()

" -------------- LSP Saga Config
nnoremap <silent>K :Lspsaga hover_doc<CR>

" Use tab for scroll only when the Lspsaga hover is visible
nnoremap <silent><expr> <Tab> luaeval("require('lspsaga.hover').has_saga_hover()") ? "\<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)\<CR>" : "\<Tab>"
nnoremap <silent><expr> <S-Tab> luaeval("require('lspsaga.hover').has_saga_hover()") ? "\<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)\<CR>" : "\<S-Tab>"

nnoremap <silent> gs :Lspsaga signature_help<CR>

nnoremap <silent><leader>rn :Lspsaga rename<CR>
nnoremap <silent>gD :Lspsaga preview_definition<CR>

nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" nnoremap <silent><leader>ed <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>e <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>a :Lspsaga code_action<CR>
vnoremap <silent><leader>a :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

" -------------- NVim cmp
set completeopt=menu,menuone,noselect

lua require("cmp_conf")

"inoremap <silent><expr> <Tab>   compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <S-Tab> compe#scroll({ 'delta': -4 })

" -------------- Lightspeed
" let g:coq_settings = { 'auto_start': v:true }
nmap <leader>s <Plug>Lightspeed_s
nmap <leader>S <Plug>Lightspeed_S

lua require('lightspeed').setup{}

silent! unmap s
silent! unmap S

" -------------- DAP
lua require("dap_conf")

" -------------- Treesitter
lua require("treesitter")

" -------------- Formatter
lua require("formatter_conf").setup()

nnoremap <silent> <leader>f :Format<CR> :w<CR>

" -------------- Trouble
lua require("trouble").setup {}

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" -------------- Galaxy Line
let s:configuration = sonokai#get_configuration()
let g:palette = sonokai#get_palette(s:configuration.style)

lua require('galaxyline_conf')

" -------------- Ranger
"let g:rnvimr_draw_border = 1
"let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
"let g:rnvimr_enable_picker = 1
"let g:rnvimr_hide_gitignore = 0
"let g:rnvimr_enable_bw = 1

"tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
"nnoremap <silent> <A-q> :RnvimrToggle<CR>
"tnoremap <silent> <A-q> <C-\><C-n>:RnvimrToggle<CR>

" -------------- Nvim tree
lua require('nvim_tree_conf')

nnoremap <A-q> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

NvimTreeClose

" -------------- Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" -------------- Vim Test
let g:cmux_elixir_tmux_session = 'elixir-test-session'

function! DispatchEnv(cmd) abort
    let env_file = getcwd() . "/.env"
    if filereadable(env_file)
        return "eval $(egrep -v '^\\#' " . env_file . " | xargs) " . a:cmd
    else
        return a:cmd
    endif
endfunction

function! CMux(cmd) abort
    " Scroll down if the panel is in scroll mode
    call system('tmux send-keys -t ' . g:cmux_elixir_tmux_session . ':1.1 ENTER')
    " Print and send the test command
    call system('tmux send-keys -t ' . g:cmux_elixir_tmux_session . ':1.1 "clear; echo ' . a:cmd . '; ' . a:cmd . '" ENTER')
endfunction

let g:test#custom_strategies = {"cmux": function("CMux")}

" let g:test#custom_transformations = {"dispatch": function("DispatchEnv")}
" let g:test#transformation = 'dispatch'

let test#strategy = "cmux"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" -------------- Vue
" Only enable this pre processor as is teh oienf ely one ai Uuse
let g:vue_pre_processors = ['html', 'scss', "typescript", "css"]

" -------------- Startify
" 'Most Recent Files' number
let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ ]

let g:startify_custom_header = [
  \ "  ",
  \ '_______________/\\\___________________________________________________       ', 
  \ ' ______________\/\\\___________________________________________________      ', 
  \ '  __/\\\________\/\\\___/\\\___________________/\\\_____________________     ', 
  \ '   _\///_________\/\\\__\///______/\\\\\_____/\\\\\\\\\\\__/\\\\\\\\\____    ', 
  \ '    __/\\\___/\\\\\\\\\___/\\\___/\\\///\\\__\////\\\////__\////////\\\___   ', 
  \ '     _\/\\\__/\\\////\\\__\/\\\__/\\\__\//\\\____\/\\\________/\\\\\\\\\\__  ', 
  \ '      _\/\\\_\/\\\__\/\\\__\/\\\_\//\\\__/\\\_____\/\\\_/\\___/\\\/////\\\__ ', 
  \ '       _\/\\\_\//\\\\\\\/\\_\/\\\__\///\\\\\/______\//\\\\\___\//\\\\\\\\/\\_', 
  \ '        _\///___\///////\//__\///_____\/////_________\/////_____\////////\//_'
  \ ]

