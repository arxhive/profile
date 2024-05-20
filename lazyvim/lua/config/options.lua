-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.guicursor = ""

vim.opt.swapfile = false
vim.opt.scrolloff = 10
vim.opt.wrap = false

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.showtabline = 2 -- show always, to avoid conflicts with lualine config

vim.opt.list = false -- hide ident marks in the insert mode

vim.o.splitright = true -- splitting a window will put the new window right of the current one

require("lazyvim.util").lsp.on_attach(function()
  vim.opt.signcolumn = "yes"
end)
