-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- or  ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

-- verbose map <leader>.. to describe existing shortcut
-- help key-notation - describe special keys

-- vim.keymap.set("n", "<C-S-i>", require("lspimport").import, { noremap = true })

-- stylua: ignore start
vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set("n", "<Enter>",function() vim.cmd("Kindle") end, { desc = "Turn on code mode"})

vim.keymap.set("n", "<leader>cd",
  function()
    vim.cmd("cd %:h")
    print("cwd: " .. vim.uv.cwd())
  end,
  { desc = "Change cwd to the current folder" })

-- Terminal
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
vim.keymap.set({ "n", "i", "x" }, "<C-?>", lazyterm, { desc = "Terminal (root)" })
vim.keymap.set({ "n", "i", "x" }, "<C-/>",
  function()
    local path = vim.fn.expand("%:h:p")
    -- handle oil explorer prefix: "oil:///..."
    if string.find(path, "oil") then
      path = string.sub(path, 6)
    end
    LazyVim.terminal(nil, { cwd = path })
  end, { desc = "Terminal (current folder)" })

-- Buffers
vim.keymap.set("n", "<C-`>", ":BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })

-- Resize windows
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +10<CR>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -10<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Up>", ":resize +5<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", ":resize -5<CR>", { desc = "Decrease window height" })

-- Move lines
vim.keymap.set("n", "<C-S-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<C-S-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<C-S-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<C-S-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<C-S-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<C-S-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Append lines
vim.keymap.set("n", "<S-q>", function()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, {""})
end, { desc = "Append line above" })
vim.keymap.set("n", "q", function()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, cursor_line, cursor_line, false, {""})
end, { desc = "Append line below" })

vim.keymap.set("n", "<S-CR>", "i<CR><ESC>kg_", { desc = "Break the line" })
vim.keymap.set("n", "<BS>", "i<C-w><ESC>", { desc = "Delete a word" })

-- Navigation
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
-- vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })

-- Navigation experiments
-- vim.keymap.set("n", "1", "<C-W>h", {desc = "Left window"})
-- vim.keymap.set("n", "2", "<C-W>j", {desc = "Bottom window"})
-- vim.keymap.set("n", "3", "<C-W>k", {desc = "Top window"})
-- vim.keymap.set("n", "4", "<C-W>l", {desc = "Right window"})

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
vim.keymap.set("n", "=", "gg=G")

-- Open defintion in vertical split
vim.keymap.set("n", "<tab>", function ()
  local original_window = vim.api.nvim_get_current_win()
  vim.api.nvim_command("vsplit | vertical resize 100")
  vim.lsp.buf.definition()

  -- Wait LSP server response
  vim.wait(100, function() end)

  vim.api.nvim_set_current_win(original_window)
end, { silent = true, desc = "Vert split definition" })

vim.keymap.set("n", "<S-tab>", function ()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l><leader>wd", true, false, true), "m", false)
  -- vim.cmd("close")
end, { silent = true, desc = "Close a right window" })

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

vim.keymap.set("n", "<leader>rs", [[:%s/]], { desc = "Simple replace by regex" })
vim.keymap.set("n", "<leader>rx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace by regex - old/new" })
vim.keymap.set("x", "<leader>rx", [[:s/\(.*\)/_\1_]], { desc = "Suround by regex - old/new" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
vim.keymap.set("x", "<leader>p", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })

vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

-- Database Explorer
vim.keymap.set("n", "<C-S-D>", function() vim.cmd("DBUIToggle") end, { desc = "Toggle Database Explorer" })

-- stylua: ignore end
