-- Keymaps are automatically loaded on the VeryLazy event 
-- Default keymaps that are always set: 
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- or  ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

-- verbose map <leader>.. to describe existing shortcut

-- stylua: ignore start
vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set("n", "<Enter>",function() vim.cmd("Kindle") end, { desc = "Turn on code mode"})

-- Telescope
vim.keymap.set("n", "<C-f>", function() vim.cmd("Telescope live_grep") end, { desc = "Grep" })
vim.keymap.set({ "n","x" }, "<C-S-f>", function() vim.cmd("Telescope grep_string") end, { desc = "Grep string" })

-- Buffers
vim.keymap.set("n", "<C-`>", ":BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })

-- Resize windows
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { desc = "Decrease window height" })

-- Move lines
vim.keymap.set("n", "<C-S-j>", ":m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<C-S-k>", ":m -2<CR>", { desc = "Move line up" })

vim.keymap.set("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<S-q>", function()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, {""})
end, { desc = "Append line above" })
vim.keymap.set("n", "q", function()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, cursor_line, cursor_line, false, {""})
end, { desc = "Append line below" })
vim.keymap.set("n", "<BS>", "i<CR><ESC>kg_", { desc = "<Break the line" })

-- Navigation
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
-- vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("n", "1", "<C-W>h", {desc = "Left window"})
vim.keymap.set("n", "2", "<C-W>j", {desc = "Bottom window"})
vim.keymap.set("n", "3", "<C-W>k", {desc = "Top window"})
vim.keymap.set("n", "4", "<C-W>l", {desc = "Right window"})

vim.keymap.set("i", "©", "<ESC>", { desc = "Escape edit mode" }) -- used for iterm command mapping

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "]]", "j0[[%/{<CR>", { desc = "Go to prev usage of" })
vim.keymap.set("n", "[[", "?{<CR>w99[{", { desc = "Go to next usage of" })

vim.keymap.set("i", "<C-u>", "<ESC>u", { silent = true, noremap = true })

-- Semantic
vim.keymap.set({ "i", "n" }, "<C-a>", function() vim.lsp.buf.signature_help() end, { desc = "Signature help on edit mode" })

-- Refactoring
-- https://github.com/ThePrimeagen/refactoring.nvim
vim.keymap.set({ "n", "x" }, "<leader>rr", function() require("refactoring"):select_refactor() end, { desc = "Refactor Menu" })

vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract Function" })
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract Function to File" })

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract Variable" })

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline Variable" })

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline Function" })

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract Block" })
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract Block to file" })

vim.keymap.set("n", "<leader>rx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace by regex - old/new" })
vim.keymap.set("x", "<leader>rx", [[:s/\(.*\)/_\1_]], { desc = "Suround by regex - old/new" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
vim.keymap.set("x", "<leader>p", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })

vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

-- Database Explorer
vim.keymap.set("n", "<C-S-D>", function() vim.cmd("DBUIToggle") end, { desc = "Toggle Database Explorer" })

-- Noice cmdline
-- vim.keymap.set("n", "<S-CR>", ":!", { desc = "Cmdline shell" })

-- stylua: ignore end
