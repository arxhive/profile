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

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline = "neovim",
      content = "text",
      priority = 0,
      selector = "textarea",
      takeover = "never",
    },
  },
}

-- Change cursor line accents for insert mode
vim.cmd([[
  augroup CursorLineToggle
    autocmd!
  " Insert Enter
    autocmd InsertEnter * highlight CursorLine guibg=#181825 " mantle
    autocmd InsertEnter * highlight CursorLineNr guifg=#f5c2e7 " pink
    " autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=NONE guibg=#24273a " base macchiato
    " autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=NONE guibg=#11111b " crust
  " Insert Leave
    autocmd InsertLeave * highlight CursorLine guibg=#2a2b3c
    autocmd InsertLeave * highlight CursorLineNr guifg=#b4befe " default
  augroup END
]])

-- Do not store marks 0 to 9 are automatically created by vim and stored in the viminfo and clear existing
vim.opt.shada:append("f0")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("delmarks 0-9")
  end,
})
