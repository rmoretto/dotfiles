syntax on

" Remapping leader key
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

" Vim Plug
call plug#begin('~/.vim/plugged')

" Colorshemes
Plug 'https://github.com/sainnhe/sonokai'

" Utils
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/kevinhwang91/rnvimr'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/mhinz/vim-startify'
Plug 'https://github.com/simeji/winresizer'

" Code utils
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/preservim/nerdcommenter'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/tpope/vim-dotenv'

" Code Config
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/elixir-editors/vim-elixir'
Plug 'https://github.com/vim-test/vim-test'
Plug 'https://github.com/raimondi/delimitmate'

call plug#end()

" ------- Themes
if has('termguicolors')
    set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai

" -------- Linha voadora
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme = 'sonokai'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

let g:airline#extensions#tabline#enabled = 1

" ------- FFZFZF
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!{node_modules,.git}"'

" ------- rangresr
" Boridnha SHOW
let g:rnvimr_draw_border = 1
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'
let g:rnvimr_enable_ex = 1
let g:rnvimr_enable_picker = 1

tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <A-q> :RnvimrToggle<CR>
tnoremap <silent> <A-q> <C-\><C-n>:RnvimrToggle<CR>

" ------ WIN Reserziers
noremap <C-e> :WinResizerStartFocus<CR>

" ----- KeyMAPERS
nnoremap <F12> :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>y "+y
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>

nnoremap <silent> <S-A-l> :bnext<CR>
nnoremap <silent> <S-A-h> :bprev<CR>
nnoremap <silent> <A-w> :bdelete<CR>

" move libe BABYYYY
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <Leader><CR> :noh<cr>

" ----- Vim Test
let test#strategy = "neovim"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ----- Terminal EU QUE FIZ
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        try
            exec "botright sbuffer " . g:term_buf
            exec "resize " . a:height
        catch
            botright new
            exec "resize " . a:height

            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" ----- COCO BIMV
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <TAB> coc#float#has_scroll() ? coc#float#scroll(1) : "\<TAB>"
  nnoremap <silent><nowait><expr> <S-TAB> coc#float#has_scroll() ? coc#float#scroll(0) : "\<S-TAB>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" ------ STARTIF
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

