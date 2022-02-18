-- eu q fiz kkk
require'nvim-tree'.setup {
  hijack_cursor       = true,
  update_cwd          = true,
  auth_close          = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {"none"},
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
  },
  view = {
    width = 45,
  }
}
