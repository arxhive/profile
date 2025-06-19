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

-- don't hide my json strings
vim.opt.conceallevel = 0

-- disable all lazyvim animations
-- vim.g.snacks_animate = false

-- This setting controls how long Neovim waits for a key sequence to complete after pressing the <esc> key.
-- good example is mapping to "md", if timeoutlen is 0, md will not work, I have 100ms to finish it.
vim.opt.timeoutlen = 100

-- This setting controls how long Neovim waits for a key sequence to complete after pressing <esc> when it's part of a terminal key code.
vim.opt.ttimeoutlen = 100

-- some plugins populate the signcolumn with something useful. People tend to use the gitsigns plugin, for showing deletions, changes, additions, from git.
require("lazyvim.util").lsp.on_attach(function()
  vim.opt.signcolumn = "yes"
end)
