local keymap = vim.keymap

vim.cmd([[
    let g:tmux_test_session = 'test-session'

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
        call system('tmux send-keys -t ' . g:tmux_test_session . ':1.1 ENTER')

        let root_dir = finddir('.git/..', expand('%:p:h').';')
        call system('tmux send-keys -t ' . g:tmux_test_session . ':1.1 "cd ' . root_dir . '" ENTER')

        call system('tmux send-keys -t ' . g:tmux_test_session . ':1.1 "clear; echo ' . a:cmd . '; ' . a:cmd . '" ENTER')
    endfunction

    let g:test#custom_strategies = {"cmux": function("CMux")}
    let test#strategy = "cmux"
]])

local opts = { noremap = true, silent = true }
keymap.set("n", "t<C-n>", ":TestNearest<CR>", opts)
keymap.set("n", "t<C-f>", ":TestFile<CR>", opts)
keymap.set("n", "t<C-s>", ":TestSuite<CR>", opts)
keymap.set("n", "t<C-l>", ":TestLast<CR>", opts)
keymap.set("n", "t<C-g>", ":TestVisit<CR>", opts)
