local cmp = require 'cmp'
local types = require 'cmp.types'

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

cmp.setup({
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    completion = {completeopt = 'menu,menuone,noinsert'},
    mapping = {
        -- Nice
        ['<C-f>'] = cmp.mapping(cmp.mapping.select_next_item(
                                    {behavior = types.cmp.SelectBehavior.Insert}),
                                {'i', 'c'}),
        ['<C-b>'] = cmp.mapping(cmp.mapping.select_prev_item(
                                    {behavior = types.cmp.SelectBehavior.Insert}),
                                {'i', 'c'}),

        -- BIG nice
        --['<Tab>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        --['<S-Tab>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = {
        {name = 'vsnip'}, {name = 'nvim_lsp'}, {name = 'path'}, 
        {name = 'buffer'}, {name = 'emoji'}
    }
})
