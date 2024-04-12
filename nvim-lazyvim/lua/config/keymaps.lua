-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
vim.keymap.set("n", "<Bslash>", ":")

-- Telescope
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)
-- Buffers
vim.keymap.set("n", "<C-`>", ":BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })

-- Resize windows
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { desc = "Decrease window height" })

-- Move lines
vim.keymap.set("n", "<C-j>", ":m +1<CR>", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m -2<CR>", { desc = "Move line up" })

vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<S-N>", "_i<CR><ESC>_", { desc = "Append line above" })
vim.keymap.set("n", "<S-M>", "<CR>_i<CR><ESC>kk_", { desc = "Append line below" })

-- Navigation
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "kk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "hh", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "ii", "<ESC>", { desc = "Escape edit mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "]]", "j0[[%/{<CR>", { desc = "Go to prev usage of" })
vim.keymap.set("n", "[[", "?{<CR>w99[{", { desc = "Go to next usage of" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste overwrite" })
vim.keymap.set("i", "uu", "<ESC>u", { desc = "Escape and undo" })

-- Semantic
vim.keymap.set({ "i", "n" }, "<C-a>", function()
  vim.lsp.buf.signature_help()
end, { desc = "Signature help on edit mode" })

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

vim.keymap.set("n", "<leader>rx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace by regex" })

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

-- Oil
vim.keymap.set("n", "<C-S-W>", function()
  require("oil").toggle_float()
end)

vim.keymap.set("n", "<C-S-O>", function()
  require("oil").open()
end)

-- UndoTree
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)
