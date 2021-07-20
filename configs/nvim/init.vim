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

"autocmd FileType ruby setlocal ts=2 sts=2 sw=2


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
Plug 'nvim-lua/popup.nvim'
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

" Misc
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/preservim/nerdcommenter'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/vim-test/vim-test'
Plug 'https://github.com/raimondi/delimitmate'
Plug 'tommcdo/vim-exchange'

" IDE Like 
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'elixir-editors/vim-elixir'
Plug 'mhartington/formatter.nvim'
Plug 'folke/trouble.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

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

nnoremap <Leader><CR> :noh<cr>
nnoremap <Leader><CR> :let @/ = ""<cr>

" Quick fix Key maps
nnoremap <silent> <leader>x :ccl <CR>
nnoremap <silent> <leader>z :cexpr system('git grep --line-number -e PERFORMANCE -e FIXME -e TODO') <CR> :botright copen <CR>

" New map to start and of line
"nnoremap <silent> <C-i> :normal ^<CR>
"nnoremap <silent> <C-a> :normal $<CR>

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
lua require("lsp")

" -------------- LSP Saga Config
nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent> gs :Lspsaga signature_help<CR>

nnoremap <silent>gr :Lspsaga rename<CR>
nnoremap <silent>gD :Lspsaga preview_definition<CR>

nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>

" nnoremap <silent><leader>ed <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>e <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>a :Lspsaga code_action<CR>
vnoremap <silent><leader>a :<C-U>Lspsaga range_code_action<CR>

nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

" -------------- NVim Compe Config
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.ultisnips = v:false

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

lua require("nvim_compe")

"inoremap <silent><expr> <Tab>   compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <S-Tab> compe#scroll({ 'delta': -4 })

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
let g:rnvimr_draw_border = 1
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
let g:rnvimr_enable_picker = 1

tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <A-q> :RnvimrToggle<CR>
tnoremap <silent> <A-q> <C-\><C-n>:RnvimrToggle<CR>

" -------------- Vim Test
function! DispatchEnv(cmd) abort
    let env_file = getcwd() . "/.env"
    if filereadable(env_file)
        return "eval $(egrep -v '^\\#' " . env_file . " | xargs) " . a:cmd
    else
        return a:cmd
    endif
endfunction

let g:test#custom_transformations = {"dispatch": function("DispatchEnv")}
let g:test#transformation = 'dispatch'

let test#strategy = "dispatch"
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

