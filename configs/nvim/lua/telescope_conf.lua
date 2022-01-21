local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')


-- Disable elixir highligh
------------------------------
-- local _bad = { '.*%.exs', '.*%.ex' } -- Put all filetypes that slow you down in this array
local _bad = { } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require('telescope').setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}

-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg', '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    -- file_ignore_patterns = {"node_modules", ".git/", "/^_build/", ".idea", ".elixis_ls"},
    buffer_previewer_maker = new_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,       -- otherwise, just set the mapping to the function that you want it to be.
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
      },
      n = {
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist
      }
    },
  }
}
