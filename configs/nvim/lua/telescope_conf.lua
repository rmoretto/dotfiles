local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
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
