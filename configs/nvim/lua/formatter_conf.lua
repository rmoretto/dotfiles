local M = {}

local function prettier()
    return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

local function black() return {exe = "black", args = {"-q", "-"}, stdin = true} end

local function mix_format()
    return {exe = "mix", args = {"format", "mix.exs", "-"}, stdin = true}
end

local function luaformat()
    return {exe = "lua-format", args = {"-i"}, stdin = true}
end

local function rustformat()
    return {exe = "rustfmt", args = {"--emit=stdout"}, stdin = true}
end

local function terraform()
    return {exe = "terraform", args = {"fmt", "-write=false"}, stdin = true}
end

local function hindent() return {exe = "hindent", stdin = true} end

function M.setup()
    require("formatter").setup({
        logging = true,
        filetype = {
            lua = {luaformat},
            javascript = {prettier},
            javascriptreact = {prettier},
            typescript = {prettier},
            typescriptreact = {prettier},
            vue = {prettier},
            html = {prettier},
            json = {prettier},
            css = {prettier},
            scss = {prettier},
            sass = {prettier},
            python = {black},
            elixir = {mix_format},
            haskell = {hindent},
            rust = {rustformat},
            terraform = {terraform},
        }
    })
end

return M
