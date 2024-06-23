-- bootstrap lazy.nvim, LazyVim and your plugins

-- Use nvim 0.9+ new loader with byte-compilation cache
-- https://neovim.io/doc/user/lua.html#vim.loader
vim.loader.enable()

require("config.lazy")
require("config.generics")
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
    ["q"] = "actions.close",
    ["p"] = "actions.preview",
  },
})
