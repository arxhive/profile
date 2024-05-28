-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.guicursor = ""

vim.opt.swapfile = false
vim.opt.scrolloff = 10
vim.opt.wrap = false

-- dissable slash chars for empty lines in merge tools
vim.opt.fillchars:append({ diff = " " })

-- disable transparent background for cmp
vim.opt.pumblend = 0
vim.opt.winblend = 0

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- show always, to avoid conflicts with lualine config
vim.opt.showtabline = 2

-- hide ident marks in the insert mode
vim.opt.list = false

-- splitting a window will put the new window right of the current one
vim.o.splitright = true

vim.g.deprecation_warnings = false

require("lazyvim.util").lsp.on_attach(function()
  vim.opt.signcolumn = "yes"
end)
