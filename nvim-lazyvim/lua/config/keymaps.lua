-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here

-- Telescope
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
-- Buffers
vim.keymap.set("n", "<C-`>", "<cmd>BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })

-- Resize windows
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })

-- vim.keymap.set("n", "<C-d>", "<cmd>copy .<CR>", { desc = "Duplicate line" })
-- vim.keymap.set("n", "<T-j>", "<cmd>m +1<CR>", { desc = "" })
-- vim.keymap.set("n", "<M-j>", "<cmd>m +1<CR>", { desc = "" })

-- Navigation
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("n", "[[", "?{<CR>w99[{", { desc = "Go to next usage of" })
vim.keymap.set("n", "]]", "j0[[%/{<CR>", { desc = "Go to prev usage of" })

-- Semantic
vim.keymap.set("i", "<C-k>", "vim.lsp.buf.signature_help", { desc = "Signature help on edit mode" })

-- Refactoring
-- https://github.com/ThePrimeagen/refactoring.nvim
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
  require("refactoring").select_refactor()
end, { desc = "Refactor Menu" })

vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract Function" })
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract Function to File" })

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract Variable" })

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline Variable" })

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline Function" })

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract Block" })
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract Block to file" })

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Harpoon File" })
vim.keymap.set("n", "<C-S-E>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
  harpoon:list():prev()
end, { desc = "Prev Harpoon" })
vim.keymap.set("n", "<C-S-N>", function()
  harpoon:list():next()
end, { desc = "Next Harpoon" })

vim.keymap.set("n", "<C-S-W>", function()
  require("oil").open()
end)

-- UndoTree
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)
