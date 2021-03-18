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
set title
set mouse=a

" Vim Plug
call plug#begin('~/.vim/plugged')

" Colorshemes
Plug 'https://github.com/sainnhe/sonokai'

" Utils
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
"Plug 'https://github.com/vim-airline/vim-airline'
"Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/kevinhwang91/rnvimr'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/mhinz/vim-startify'
Plug 'https://github.com/simeji/winresizer'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'edkolev/tmuxline.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'psliwka/vim-smoothie'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

" Code utils
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/preservim/nerdcommenter'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'

" Code Config
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/vim-test/vim-test'
Plug 'https://github.com/raimondi/delimitmate'
Plug 'https://github.com/OmniSharp/omnisharp-vim'
Plug 'sheerun/vim-polyglot'

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

" ------- LIansh galatxita
let s:configuration = sonokai#get_configuration()
let g:palette = sonokai#get_palette(s:configuration.style)

lua << EOF
local gl = require('galaxyline')
local condition = require('galaxyline.condition')

local gls = gl.section
gl.short_line_list = {'defx', 'packager', 'vista', 'NvimTree'}

local utils = {}
function utils.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function utils.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

local colors = {
    bg = vim.g.palette.bg0[1],
    fg = vim.g.palette.fg[1],
    section_bg = vim.g.palette.bg2[1],
    blue = vim.g.palette.blue[1],
    green = vim.g.palette.green[1],
    purple = vim.g.palette.purple[1],
    orange = vim.g.palette.orange[1],
    red1 = vim.g.palette.red[1],
    red2 = vim.g.palette.diff_red[1],
    yellow = vim.g.palette.yellow[1],
    gray1 = vim.g.palette.grey[1],
    gray2 = vim.g.palette.grey[1],
    gray3 = vim.g.palette.grey[1],
    darkgrey = vim.g.palette.bg3[1],
    grey = vim.g.palette.bg4[1],
    middlegrey = vim.g.palette.fg[1]
}

-- Local helper functions
local buffer_not_empty = function() return not utils.is_buffer_empty() end

local checkwidth = function()
    return utils.has_width_gt(35) and buffer_not_empty()
end

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value[1] == val then return true end
    end
    return false
end

local mode_color = function()
    local mode_colors = {
        [110] = colors.green,
        [105] = colors.blue,
        [99] = colors.green,
        [116] = colors.blue,
        [118] = colors.purple,
        [22] = colors.purple,
        [86] = colors.purple,
        [82] = colors.red1,
        [115] = colors.red1,
        [83] = colors.red1
    }

    mode_color = mode_colors[vim.fn.mode():byte()]
    if mode_color ~= nil then
        return mode_color
    else
        return colors.purple
    end
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. ' [   salva babaca ]' end
    end
    return file .. ' '
end

-- local function trailing_whitespace()
--     local trail = vim.fn.search('\\s$', 'nw')
--     if trail ~= 0 then
--         return '  '
--     else
--         return nil
--     end
-- end

-- local function tab_indent()
--     local tab = vim.fn.search('^\\t', 'nw')
--     if tab ~= 0 then
--         return ' → '
--     else
--         return nil
--     end
-- end

local function buffers_count()
    local buffers = {}
    for _, val in ipairs(vim.fn.range(1, vim.fn.bufnr('$'))) do
        if vim.fn.bufexists(val) == 1 and vim.fn.buflisted(val) == 1 then
            table.insert(buffers, val)
        end
    end
    return #buffers
end

-- Left side
gls.left[1] = {
    ViMode = {
        provider = function()
            local aliases = {
                [110] = 'NORMAL',
                [105] = 'INSERT',
                [99] = 'COMMAND',
                [116] = 'TERMINAL',
                [118] = 'VISUAL',
                [22] = 'V-BLOCK',
                [86] = 'V-LINE',
                [82] = 'REPLACE',
                [115] = 'SELECT',
                [83] = 'S-LINE'
            }

            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
            alias = aliases[vim.fn.mode():byte()]
            if alias ~= nil then
                if utils.has_width_gt(35) then
                    mode = alias
                else
                    mode = alias:sub(1, 1)
                end
            else
                mode = vim.fn.mode():byte()
            end
            return '  ' .. mode .. ' '
        end,
        highlight = {colors.bg, colors.bg, 'bold'}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = buffer_not_empty,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.left[3] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}
-- Right side
gls.right[1] = {
    DiffAdd = {
        provider = 'DiffAdd',
        separator = ' ',
        condition = checkwidth,
        icon = '  +',
        highlight = {colors.green, colors.section_bg},
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.right[2] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = '~',
        highlight = {colors.orange, colors.section_bg}
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = '-',
        highlight = {colors.red1, colors.section_bg}
    }
}

gls.right[4] = {
    Space = {
        provider = function() return ' ' end,
        highlight = {colors.section_bg, colors.section_bg}
    }
}

gls.right[5] = {
    GitIcon = {
        provider = function() return '  ' end,
        condition = buffer_not_empty and
            require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.middlegrey, colors.section_bg}
    }
}

gls.right[6] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = buffer_not_empty,
        highlight = {colors.middlegrey, colors.section_bg}
    }
}

gls.right[7] = {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.blue, colors.section_bg},
        highlight = {colors.grey, colors.blue}
    }
}



-- gls.right[8] = {
--     ScrollBar = {
--         provider = 'ScrollBar',
--         highlight = {colors.purple, colors.section_bg}
--     }
-- }

-- Short status line
gls.short_line_left[1] = {
    FileIcon = {
        provider = {function() return '  ' end, 'FileIcon'},
        condition = function()
            return buffer_not_empty and
                       has_value(gl.short_line_list, vim.bo.filetype)
        end,
        highlight = {
            require('galaxyline.provider_fileinfo').get_file_icon,
            colors.section_bg
        }
    }
}
gls.short_line_left[2] = {
    FileName = {
        provider = get_current_file_name,
        condition = buffer_not_empty,
        highlight = {colors.fg, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = 'BufferIcon',
        highlight = {colors.yellow, colors.section_bg},
        separator = '',
        separator_highlight = {colors.section_bg, colors.bg}
    }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
EOF



" -------- Linha voadora
"if !exists('g:airline_symbols')
  "let g:airline_symbols = {}
"endif

"let g:airline_theme = 'sonokai'
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = ''

"let g:airline#extensions#tabline#enabled = 1
"let g:airline_highlighting_cache = 1

"let g:airline_extensions = []

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
"noremap <C-e> :WinResizerStartFocus<CR>

" ----- KeyMAPERS
nnoremap <F12> :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>

" vai emorvra wtermina lidiota 
function! BnSkipTerm()
  let start_buffer = bufnr('%')
  bn
  while &buftype ==# 'terminal' && bufnr('%') != start_buffer
    bn
  endwhile
endfunction
function! BpSkipTerm()
  let start_buffer = bufnr('%')
  bp
  while &buftype ==# 'terminal' && bufnr('%') != start_buffer
    bp
  endwhile
endfunction
nnoremap <silent> <S-A-l> :call BnSkipTerm()<CR>
nnoremap <silent> <S-A-h> :call BpSkipTerm()<CR>

nnoremap <silent> <A-w> :call BpSkipTerm()\|bdelete #<CR>

" move libe BABYYYY
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <Leader><CR> :noh<cr>
nnoremap <Leader><CR> :let @/ = ""<cr>

" ----- Vim Test
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

" ----- Uniters OMIUNS
let g:OmniSharp_server_use_mono = 1

" --- -ENVS
function! s:env(var) abort
  return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

function! Env()
    redir => s
    sil! exe "norm!:ec$\<c-a>'\<c-b>\<right>\<right>\<del>'\<cr>"
    redir END
    return split(s)
endfunction

" ----- CVSS CSCOCO
autocmd FileType scss setl iskeyword+=@-@


" ------ Vuezers
" Only enable this pre processor as is teh oienf ely one ai Uuse
let g:vue_pre_processors = ['html', 'scss', "typescript", "css"]

" ------ find TODOS ETRC
nnoremap <silent> <leader>x :ccl <CR>
nnoremap <silent> <leader>z :cexpr system('git grep --line-number -e PERFORMANCE -e FIXME -e TODO') <CR> :botright copen <CR>

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
"xmap <leader>f  :Format<CR>
"nmap <leader>f  :Format<CR>

xmap <leader>f :Format<CR> :update<CR>
nmap <leader>f :Format<CR> :update<CR>
nmap <C-A-o> :call CocAction('runCommand', 'editor.action.organizeImport')<CR> :update<CR>

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

