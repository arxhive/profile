-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
vim.keymap.set("n", "<C-`>", "<cmd>BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -5<CR>", { desc = "Decrease window height" })

-- vim.keymap.set("n", "<C-d>", "<cmd>copy .<CR>", { desc = "Duplicate line" })
