-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
--
-- must be in init.lua to support "v ."
require("oil").setup({
  default_file_explorer = true,
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = false,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["<bs>"] = "actions.parent",
  },
})
