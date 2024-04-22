-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
-- stylua: ignore start
vim.keymap.set({ "n", "x" }, "<Bslash>", ":")

-- Telescope
vim.keymap.set("n", "<leader>sl", require("telescope").extensions.luasnip.luasnip, { noremap = true, silent = true, desc = "luasnip" })

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

vim.keymap.set("n", "<S-Q>", "O<ESC>j_", { desc = "Append line above" })
vim.keymap.set("n", "q", "o<ESC>k_", { desc = "Append line below" })
vim.keymap.set("n", "<BS>", "i<CR><ESC>kg_", { desc = "<Break the line" })

-- Navigation
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })
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

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon File" })
vim.keymap.set("n", "<C-S-E>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<PageUp>", function() harpoon:list():prev() end, { desc = "Prev Harpoon" })
vim.keymap.set("n", "<PageDown>", function() harpoon:list():next() end, { desc = "Next Harpoon" })
-- vim.keymap.del("n", "<leader>H")

-- Yanky
vim.keymap.set({"n","x", "i"}, "<C-S-P>", function() require("telescope").extensions.yank_history.yank_history() end, { desc = "Telescope yank history" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
vim.keymap.set("x", "<leader>p", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })

vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

-- Aerial
vim.keymap.set("n", "<C-S-S>", function() require("aerial").toggle() end, { desc = "Toggle Aerial" })

-- Database Explorer
vim.keymap.set("n", "<C-S-D>", function() vim.cmd("DBUIToggle") end, { desc = "Toggle Database Explorer" })

-- Noice
vim.keymap.set("n", "<leader>snt", function() vim.cmd("Noice telescope") end, { desc = "Noice telescope" })

-- Noice cmdline
vim.keymap.set("n", "<S-CR>", ":!", { desc = "Cmdline shell" })

-- stylua: ignore end
