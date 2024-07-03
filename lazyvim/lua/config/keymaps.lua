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
vim.keymap.del( { "n" }, "<leader><Tab>o")
vim.keymap.del( { "n" }, "<leader><Tab>[")
vim.keymap.del( { "n" }, "<leader><Tab>]")
vim.keymap.del( { "n" }, "<leader><Tab><Tab>")

-- Clear yanky history mapping
vim.keymap.del( { "n" }, "<leader>p")

-- Clear others
vim.keymap.set("n", "<leader>L", "", { desc = "+lazy"})
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>`")

-- Remap LazyVim defaults
vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, { desc = "Goto type defintion" })
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Goto defintion" })
vim.keymap.set("n", "<leader>Ls", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>cm", LazyVim.lsp.action["source.addMissingImports.ts"], { desc = "Add missing imports" })
-- vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>rr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Rename", expr = true })
vim.keymap.set("n", "<leader>rR", LazyVim.lsp.rename_file, { desc = "Rename File", })

vim.keymap.set("n","<leader>xx", function() vim.api.nvim_command("Trouble diagnostics toggle focus=true") end,  { desc = "Diagnostics"})
vim.keymap.set("n","<leader>xX", function() vim.api.nvim_command("Trouble diagnostics toggle focus=true filter.buf=0") end,  { desc = "Buffer diagnostics"})
vim.keymap.set("n","<leader>xe", function() vim.api.nvim_command("Telescope diagnostics") end,  { desc = "Diagnostics (telescope)"})

-- Lifehacks
vim.keymap.set("i", "©", "<ESC><ESC>", { desc = "Escape edit mode" }) -- used for iterm command mapping

vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set({ "n", "i" }, "<F12>", function() vim.api.nvim_command("Kindle") end, { desc = "Turn on code mode"})

-- Terminal
local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
vim.keymap.set({ "n", "i", "x" }, "<C-?>", lazyterm, { desc = "Terminal (root)" })
vim.keymap.set({ "n", "i", "x" }, "<C-/>",
  function()
    local path = tricks.refined("%:h:p")
    LazyVim.terminal(nil, { cwd = path })
  end, { desc = "Terminal (current folder)" })

-- Git aliases
vim.keymap.set("n", "<leader>gr", function() tricks.sidecart("git fresh") end, { desc = "Refresh from master" })
vim.keymap.set("n", "<leader>gn",
  function()
    local new_branch_name = vim.fn.input("Branch name: ")
    if new_branch_name ~= "" then 
      tricks.sidecart("git fresh-b " .. new_branch_name)
    end
  end, { desc = "New Branch" })

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
vim.keymap.set("n", "<BS>", "i<C-w><Del><ESC>", { desc = "Delete a word" })

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

vim.keymap.set("n", "<PageUp>", function() require('illuminate').goto_prev_reference() end, { desc = "Prev reference" })
vim.keymap.set("n", "<PageDown>", function() require('illuminate').goto_next_reference() end, { desc = "Next reference" })

-- Open defintion in vertical split
vim.keymap.set("n", "<Tab>", function ()
  local original_window = vim.api.nvim_get_current_win()
  vim.api.nvim_command("vsplit | vertical resize 100")
  vim.lsp.buf.definition()

  -- Wait LSP server response
  vim.wait(100, function() end)

  vim.api.nvim_set_current_win(original_window)
end, { silent = true, desc = "Vert split definition" })

vim.keymap.set("n", "<S-Tab>", function ()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l><leader>wd", true, false, true), "m", false)
end, { silent = true, desc = "Close a right window" })

-- by default, <C-i> = <tab>. Restore a proper navigation behavour
vim.keymap.set({ "n", "i" }, "<C-i>", "<C-S-i>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>rs", [[:%s///gI<Left><Left><Left><Left>]], { desc = "Simple replace by regex" })
vim.keymap.set("n", "<leader>rx", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace selected by regex" })
vim.keymap.set("x", "<leader>rx", [[:s/\(.*\)/___\1___]], { desc = "Suround by regex - before and after" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
-- vim.keymap.set("x", "P", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })
vim.keymap.set("x", "p", "pgvy", { desc = "Paste and keep in register", silent = true })

-- vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
-- vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

vim.keymap.set("n", "<leader>Ll", function() vim.api.nvim_command("Lazy") end, { desc = "Lazy" })
vim.keymap.set("n", "<leader>Lx", function() vim.api.nvim_command("LazyExtras") end, { desc = "LazyExtas" })
vim.keymap.set("n", "<leader>Lm", function() vim.api.nvim_command("Mason") end, { desc = "Mason" })
vim.keymap.set("n", "<leader>Lh", function() vim.api.nvim_command("LazyHealth") end, { desc = "Healthcheck" })
vim.keymap.set("n", "<leader>LM", function() vim.api.nvim_command("checkhealth mason") end, { desc = "Healthcheck Mason" })
vim.keymap.set("n", "<leader>LL", function() vim.api.nvim_command("checkhealth lsp") end, { desc = "Healthcheck LSP" })
vim.keymap.set("n", "<leader>Lf", function()
  vim.api.nvim_command("LazyFormatInfo")
  vim.api.nvim_command("NoiceLast")
end, { desc = "Format Info" })
vim.keymap.set("n", "<leader>bd", function() vim.api.nvim_command("delmarks!") end, { desc = "Del Marks" })

-- stylua: ignore end
