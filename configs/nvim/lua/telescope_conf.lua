local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

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
    file_ignore_patterns = {"node_modules", ".git", "_build", ".idea", ".elixis_ls"},
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,       -- otherwise, just set the mapping to the function that you want it to be.
      },
      n = {
        ["<C-q>"] = builtin.quickfix,
      }
    },
  }
}
