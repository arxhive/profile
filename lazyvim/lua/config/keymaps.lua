-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- or  ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

-- special keys:  h keycodes
--             :  h key-notation
-- describe existing shortcuts:  verbose map <leader>..

-- vim.keymap.set("n", "<C-S-i>", require("lspimport").import, { noremap = true })

local tricks = require("config.tricks")

-- stylua: ignore start
-- Tabs are evil, remove all mapping
vim.keymap.del( { "n" }, "<leader><Tab>d")
vim.keymap.del( { "n" }, "<leader><Tab>f")
vim.keymap.del( { "n" }, "<leader><Tab>l")
vim.keymap.del( { "n" }, "<leader><Tab>[")
vim.keymap.del( { "n" }, "<leader><Tab>]")
vim.keymap.del( { "n" }, "<leader><Tab><Tab>")

vim.keymap.set("i", "©", "<ESC><ESC>", { desc = "Escape edit mode" }) -- used for iterm command mapping

vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set({ "n", "i" }, "<F12>", function() vim.cmd("Kindle") end, { desc = "Turn on code mode"})

-- handle oil prefix + autostart
vim.keymap.set("n", "<leader>cd",
  function()
    local path = tricks.refined("%:h")
    vim.cmd("cd " .. path)
    print("cwd: " .. vim.uv.cwd())
  end,
  { desc = "Change cwd to the current folder" })

-- Terminal
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
vim.keymap.set({ "n", "i", "x" }, "<C-?>", lazyterm, { desc = "Terminal (root)" })
vim.keymap.set({ "n", "i", "x" }, "<C-/>",
  function()
    local path = tricks.refined("%:h:p")
    LazyVim.terminal(nil, { cwd = path })
  end, { desc = "Terminal (current folder)" })

-- Git aliases
vim.keymap.set("n", "<leader>gr", ":!git fresh<CR>", { desc = "Git refresh from master" })
vim.keymap.set("n", "<leader>gn", ":!git fresh-b ", { desc = "New branch" })

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


vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("i", "<C-u>", "<ESC>u", { silent = true, noremap = true })


-- Semantic
vim.keymap.set({ "i", "n" }, "<C-a>", function() vim.lsp.buf.signature_help() end, { desc = "Signature help on edit mode" })
vim.keymap.set("n", "+", "gg=G<C-o>")

vim.keymap.set("n", "<PageUp>", function() require('illuminate').goto_next_reference() end, { desc = "Next reference" })
vim.keymap.set("n", "<PageDown>", function() require('illuminate').goto_prev_reference() end, { desc = "Prev reference" })

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
end, { silent = true, desc = "Close a right window" })

-- by default, <C-i> = <tab>. Restore a proper navigation behavour
vim.keymap.set({ "n", "i" }, "<C-i>", "<C-S-i>", { silent = true, noremap = true })

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

vim.keymap.set("n", "<leader>rs", [[:%s///gI<Left><Left><Left><Left>]], { desc = "Simple replace by regex" })
vim.keymap.set("n", "<leader>rx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace selected by regex" })
vim.keymap.set("x", "<leader>rx", [[:s/\(.*\)/___\1___]], { desc = "Suround by regex - before and after" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
vim.keymap.set("x", "P", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })

vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

-- Code runner
vim.keymap.set("n", "<leader>br",
  function()
    local current_file = vim.fn.expand("%:p")

    if string.find(current_file, ".py") then
      vim.cmd("!python " .. current_file)
    elseif string.find(current_file, ".cs") then
      vim.cmd("!dotnet run")
    elseif string.find(current_file, ".js") or  string.find(current_file, ".ts") then
      vim.cmd("!node" .. current_file)
    else LazyVim.info("Can't run this file")
    end
  end, { desc = "Run code" })


-- Builder
vim.keymap.set("n", "<leader>bb",
  function()
    local current_file = vim.fn.expand("%:p")

    if string.find(current_file, ".py") then
      vim.cmd("!pip install -r requirements.txt")
    elseif string.find(current_file, ".cs") then
      vim.cmd("!dotnet build")
      elseif string.find(current_file, ".js") or  string.find(current_file, ".ts") then
        vim.cmd("!npm install")
    else LazyVim.info("Can't build this file")
    end
  end, { desc = "Build" })

-- stylua: ignore end
