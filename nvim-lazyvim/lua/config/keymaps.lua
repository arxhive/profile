-- Keymaps are automatically loaded on the VeryLazy event Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua Add any additional keymaps here
-- stylua: ignore start
vim.keymap.set("n", "<Bslash>", ":")

-- Telescope
require("telescope").load_extension("luasnip")
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

vim.keymap.set("n", "<S-Q>", "_i<CR><ESC>_", { desc = "Append line above" })
vim.keymap.set("n", "q", "<CR>_i<CR><ESC>kk_", { desc = "Append line below" })

-- Navigation
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "kk", "<ESC>", { desc = "Escape edit mode" })
vim.keymap.set("i", "hh", "<ESC>", { desc = "Escape edit mode" })

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

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

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon File" })
vim.keymap.set("n", "<C-S-E>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<PageUp>", function() harpoon:list():prev() end, { desc = "Prev Harpoon" })
vim.keymap.set("n", "<PageDown>", function() harpoon:list():next() end, { desc = "Next Harpoon" })

-- Oil
vim.keymap.set("n", "<C-S-W>", function() require("oil").toggle_float() end)
vim.keymap.set("n", "<C-S-O>", function() require("oil").open() end)

-- UndoTree
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })

-- DAP
local dap = require("dap")
local dapui = require("dapui")
vim.keymap.set("n", "<F1>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F2>", function() dap.step_over() end, { desc = "Step Over" })

vim.keymap.set("n", "<F3>", function() dap.step_back() end, { desc = "Step Back" })
vim.keymap.set("n", "<F4>", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Continue" })
vim.keymap.set("n", "<F6>", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set({ "n", "v" }, "<F7>", function() dapui.eval() end, { desc = "Evaluate" })

-- Yanky
vim.keymap.set({"n","x", "i"}, "<C-S-P>", function() require("telescope").extensions.yank_history.yank_history() end, { desc = "Telescope yank history" })

vim.keymap.set("x", "p", [["_d<Plug>(YankyPutAfter)]], { desc = "Paste and keep in buffer" })
-- vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste in keep in buffer" })

vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")


-- Aerial
vim.keymap.set("n", "<C-S-S>", function() require("aerial").toggle() end, { desc = "Toggle Aerial" })

-- Database Explorer
vim.keymap.set("n", "<C-S-D>", function() vim.cmd("DBUIToggle") end, { desc = "Toggle Database Explorer" })

-- stylua: ignore end
