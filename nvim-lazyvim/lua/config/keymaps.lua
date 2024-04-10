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
end)

vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
