-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- or  ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

-- special keys:  h keycodes
--             :  h key-notation
-- describe existing mapping in any window or plugin:  verbose map <leader>..

-- vim.keymap.set("n", "<C-S-i>", require("lspimport").import, { noremap = true })

-- stylua: ignore start
-- Tabs are evil, remove all mapping
vim.keymap.del( { "n" }, "<leader><Tab>d")
vim.keymap.del( { "n" }, "<leader><Tab>f")
vim.keymap.del( { "n" }, "<leader><Tab>l")
vim.keymap.del( { "n" }, "<leader><Tab>o")
vim.keymap.del( { "n" }, "<leader><Tab>[")
vim.keymap.del( { "n" }, "<leader><Tab>]")
vim.keymap.del( { "n" }, "<leader><Tab><Tab>")

-- Clear git redundancy
vim.keymap.del( { "n" }, "<leader>gc")
vim.keymap.del( { "n" }, "<leader>gG")
vim.keymap.del( { "n" }, "<leader>gY")
vim.keymap.del( { "n" }, "<leader>gB")

-- Clear yanky history mapping
vim.keymap.del( { "n" }, "<leader>p")

-- Clear others
vim.keymap.del("n", "<leader>K")
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>sl")
vim.keymap.del("n", "<leader>sd")
vim.keymap.del("n", "<leader>sD")
vim.keymap.del("n", "<leader>fc")
-- vim.keymap.del("n", "<leader>be") -- a default neo-tree binding, do not need it with picker explorer
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")

-- Zoom mode
vim.keymap.del("n", "<leader>uZ")
vim.keymap.del("n", "<leader>wm")

-- Default Trouble lists
vim.keymap.del("n", "<leader>xl")
vim.keymap.del("n", "<leader>xL")
vim.keymap.del("n", "<leader>xq")

-- Remap LazyVim defaults
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Defintion" })
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Defintion" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
-- vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Goto references" }) -- disable a default gr after lsp initialization to use this one
vim.keymap.set("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "<leader>Ls", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>ci", LazyVim.lsp.action["source.addMissingImports.ts"], { desc = "Add Missing Imports" })
-- vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>rr", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Rename", expr = true })
vim.keymap.set("n", "<leader>rR", Snacks.rename.rename_file, { desc = "Rename File", })

-- Quickfix and diagnostics
vim.keymap.set("n","<leader>xx", function() vim.api.nvim_command("Telescope diagnostics") end,  { desc = "Buffer Diagnostics"})
vim.keymap.set("n","<leader>xX", function() vim.api.nvim_command("Telescope diagnostics bufnr=0") end,  { desc = "Full Diagnostics"})
vim.keymap.set("n","<leader>xq", function() vim.api.nvim_command("cope") end,  { desc = "Quickfix list"})
vim.keymap.set("n","<leader>xa",
  function()
    local new_entry = Tricks.to_quickfix()
    LazyVim.notify("New qflist entry: " .. new_entry)
    vim.api.nvim_command("cope")
  end,
  { desc = "Add To Quickfix"})

vim.keymap.set("n","<leader>xd", function() Tricks.remove_from_quickfix() end, { desc = "Delete from Quickfix"})
vim.keymap.set("n","<leader>xD", function() Tricks.clear_quickfix() end, { desc = "Nuke Quickfix"})
vim.keymap.set("n", "<leader>qx",
  function()
    -- pretty generic implementation to close any bottom window
    -- ccl - is another option to close a qf list
    vim.api.nvim_command("wincmd j")
    vim.api.nvim_command("close")
  end,
  { desc = "Quit quickfix" })
-- qflist fyi:
-- :cdo Executes a command on every item in the quickfix list.
-- :vimgrep Searches a pattern in multiple files and adds the results to the quickfix list.


-- Lifehacks
vim.keymap.set("i", "©", "<ESC><ESC>", { desc = "Escape edit mode" }) -- used for iterm command mapping

vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set({ "n", "i" }, "<F12>", function() vim.api.nvim_command("Kindle") end, { desc = "Turn on code mode"})
vim.keymap.set({ "i" }, "<M-space>", " ", { silent = true }) -- a workaround for conflict with <M-Space> forwarded from iterm2 in insert mode

vim.keymap.set({ "n" }, "<BS>", "i", { silent = true }) -- key del on mac to insert mode

-- a tricky way to set terminal bindings
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- normal swtich to normal mode on esc
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- navigation between the windows from term
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  -- back to code workspace from term
  vim.keymap.set({"t", "n"}, '<C-w>', [[<C-\><C-n><C-w><C-w>]], opts)
end

-- apply these termnial keymaps only to toggleterm windows and exclude lazygit for instance
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- Git aliases
vim.keymap.set("n", "<leader>gm", function() Tricks.sidecart("git stash-merge") end, { desc = "Stash-merge From mranch" })
vim.keymap.set("n", "<leader>gP", function() Tricks.sidecart("git stash-pull") end, { desc = "Stash-pull" })

vim.keymap.set("n", "<leader>gR", function()
  local current_file = vim.fn.expand('%:p')
  local git_path = Tricks.git_path_no_root(current_file)

  git_path = string.gsub(git_path, "^/", "") -- remove the leading slash
  vim.api.nvim_command("!git reset-one '" .. git_path .. "'")
  LazyVim.info(git_path, { title = "Reverted to master:" })
end, { desc = "Revert file to master" })

vim.keymap.set("n", "<leader>gn",
  function()
    local new_branch_name = vim.fn.input("Branch name: ")
    if new_branch_name ~= "" then
      Tricks.sidecart("git fresh-branch " .. new_branch_name)
    end
  end, { desc = "Fresh New Branch" })

vim.keymap.set("n", "<leader>gMc", function() Tricks.sidecart("git merge --continue") end, { desc = "Merge continue" })
vim.keymap.set("n", "<leader>gMa", function() Tricks.sidecart("git merge --abort") end, { desc = "Merge abort" })
vim.keymap.set("n", "<leader>gt", function() Tricks.floatterm("git tree") end, { desc = "Git Tree" })
vim.keymap.set("n", "<leader>gT", function() Tricks.floatterm("git full-tree") end, { desc = "Git Tree Detailed" })

-- my custom implementation to open file in Web browser instead of lazyvim snacks
vim.keymap.set("n", "<leader>gw", function()
  local current_file_path = vim.fn.expand('%:p') -- get the full path of the current file
  local git_path = Tricks.git_path_no_root(current_file_path)
  local relative_path = string.gsub(git_path, "^[^/]+/", "") -- repo repo name from git_path

  LazyVim.notify("Open in browser: " .. relative_path)
  Tricks.silentterm("gh " .. relative_path)
end, { desc = "Git Browse" })

vim.keymap.set("n", "<leader>gO", Beasts.git_show, { desc = "Git show original" })

-- copy origin file url
vim.keymap.set("n", "<leader>gy", function()
  local current_file_path = vim.fn.expand('%:p') -- get the full path of the current file
  local git_path = Tricks.git_path_no_root(current_file_path)
  local relative_path = string.gsub(git_path, "^[^/]+/", "") -- repo repo name from git_path

  Tricks.silentterm("ghcopy " .. relative_path)
  LazyVim.notify("Yanked origin for: " .. relative_path)
end, { desc = "Git Yank Origin" })

vim.keymap.set("n", "<leader>go", function() Tricks.floatterm("gco") end, { desc = "Checkout" })
vim.keymap.set("n", "<leader>gr", function() Tricks.floatterm("git-tags") end, { desc = "Tag refs" })

-- Buffers
-- vim.keymap.set("n", "<C-`>", ":BufferLineCycleNext<CR>", { noremap = false, desc = "Next Buffer" })

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
  -- ignore errors if not modifiable
  pcall(function()
    vim.api.nvim_buf_set_lines(0, cursor_line - 1, cursor_line - 1, false, {""})
  end)
end, { desc = "Append line above" })

vim.keymap.set("n", "q", function()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  -- ignore errors if not modifiable
  pcall(function()
    vim.api.nvim_buf_set_lines(0, cursor_line, cursor_line, false, {""})
  end)
end, { desc = "Append line below" })

vim.keymap.set("n", "<S-CR>", "i<CR><ESC>kg_", { desc = "Break the line" })
-- vim.keymap.set("n", "<BS>", "i<C-w><Del><ESC>", { desc = "Delete a word" })

-- Navigation
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
-- vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })

-- Navigation experiments
vim.keymap.set({ "n", "v" }, "<C-w>", "<C-W>w", { desc = "Prev window", nowait = true, silent = true })
-- vim.keymap.set("n", "1", "<C-W>h", {desc = "Left window"})
-- vim.keymap.set("n", "2", "<C-W>j", {desc = "Bottom window"})
-- vim.keymap.set("n", "3", "<C-W>k", {desc = "Top window"})
-- vim.keymap.set("n", "4", "<C-W>l", {desc = "Right window"})
-- vim.keymap.set({ "n", "v" }, "<Right>", "/\\u<CR>:nohlsearch<CR>", {desc = "Right window"})
-- vim.keymap.set({ "n", "v" }, "<Right>", "l/\\u<CR>h", {desc = "Next Upper"})
-- vim.keymap.set({ "n", "v" }, "<Left>", "/\\u<CR>NN", {desc = "Prev Upper"})
vim.keymap.set({ "n", "v" }, "]=", "f=w", { desc = "After =", silent = true, noremap = true })
vim.keymap.set({ "n", "v" }, "[=", "F=F b", { desc = "Before =", silent = true, noremap = true })
-- TestCamelCaseString := abc

vim.keymap.set({ "n", "v" }, "]n", "0:call search('[a-zA-Z0-9](', '', line('.'))<CR>b", { desc = "Func Name", silent = true, noremap = true })
-- vim.keymap.set({ "n", "v" }, "]n", "_t(;b", { desc = "Func Name", silent = true, noremap = true })
-- 'b' option for search means backward
vim.keymap.set({ "n" }, "dc", "i<Esc>$:call search(',', 'b', line('.'))<CR>xgi<Esc>", { desc = "Delete trail comma", silent = true, noremap = true })
-- alternative option
-- execute normal do not fail sequence if comma not found
-- vim.keymap.set({ "n" }, "dc", "i<Esc>:execute 'normal! _f,;;;'<CR>xgi<Esc>", { desc = "Delete trail comma", silent = true, noremap = true })

vim.keymap.set({ "n" }, "<S-m>", "I- <Esc>", { desc = "Bullet point", silent = true, noremap = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("i", "<C-u>", "<ESC>u", { silent = true, noremap = true })


-- Semantic
vim.keymap.set({ "i", "n" }, "<C-a>", function()
  vim.lsp.buf.hover()
  vim.lsp.buf.signature_help()
end, { desc = "Quick definition or Signature help" })
-- vim.keymap.set({ "i", "n" }, "<C-a>", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
vim.keymap.set("n", "+", "gg=G<C-o>")

vim.keymap.set("n", "<PageUp>", function() require('illuminate').goto_prev_reference() end, { desc = "Prev reference" })
vim.keymap.set("n", "<PageDown>", function() require('illuminate').goto_next_reference() end, { desc = "Next reference" })

-- Open defintion in vertical split
vim.keymap.set("n", "=", function ()
  local original_window = vim.api.nvim_get_current_win()
  vim.api.nvim_command("vsplit | vertical resize 100")
  vim.lsp.buf.definition()
  -- Snacks.picker.lsp_definitions() -- need to wait for picker input before continue in that case

  -- Wait LSP server response
  vim.wait(100, function() end)

  vim.api.nvim_set_current_win(original_window)
end, { silent = true, desc = "Vert split definition" })

vim.keymap.set("n", "-", function ()
  vim.api.nvim_command("wincmd l")
  vim.api.nvim_command("close")
end, { silent = true, desc = "Close a right window" })

vim.keymap.set("n", "<leader>wC",
  function()
    local path = Tricks.refined("%:h")
    vim.api.nvim_command("cd " .. path)
    LazyVim.notify("cwd: " .. vim.uv.cwd())
  end,
  { desc = "Change cwd to the current folder" })

-- by default, <C-i> = <tab>. Restore a proper navigation behavour
vim.keymap.set({ "n", "i" }, "<C-i>", "<C-S-i>", { silent = true, noremap = true })

-- :%s - substitute in the whole file
-- :s - substitute in the specified lines
-- <C-r><C-w> - get the work under cursor
-- <C-w> - delete a word before in command line
-- <C-u> - clear the command line after entering it from visual mode (delete all before cursor)
-- y: - yank visual selection into register
-- <C-r>* - past last yank from the registry into command line
vim.keymap.set({ "n" }, "<leader>rx", [[:%s///gI<Left><Left><Left><Left>]], { desc = "Regex Replace in Buffer" })
vim.keymap.set({ "v" }, "<leader>rx", [[:s///gI<Left><Left><Left><Left>]], { desc = "Regex Replace in Selected Block" })
vim.keymap.set({ "n" }, "<leader>rX", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace Word by Regex in Buffer" })
vim.keymap.set({ "v" }, "<leader>rX", [[y:<C-u>%s/\<<C-r>*\>/<C-r>*/gI<Left><Left><Left>]], { desc = "Replace Selected by Regex in Buffer" })
vim.keymap.set("x", "<leader>rS", [[:s/\(.*\)/___\1___]], { desc = "Regex Surround Selected Block" })

-- vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste in keep in register" })
-- vim.keymap.set("x", "P", "\"_d<Plug>(YankyPutAfter)", { desc = "Paste and keep in register" })
vim.keymap.set("x", "p", "pgvy", { desc = "Paste and keep in register", silent = true })

-- vim.keymap.set("n", "<C-P>", "<Plug>(YankyPreviousEntry)")
-- vim.keymap.set("n", "<C-N>", "<Plug>(YankyNextEntry)")

-- Lazy Info
vim.keymap.set("n", "<leader>Ll", function() vim.api.nvim_command("Lazy") end, { desc = "Lazy" })
vim.keymap.set("n", "<leader>Lx", function() vim.api.nvim_command("LazyExtras") end, { desc = "LazyExtas" })
vim.keymap.set("n", "<leader>Lm", function() vim.api.nvim_command("Mason") end, { desc = "Mason" })
vim.keymap.set("n", "<leader>Lh", function() vim.api.nvim_command("LazyHealth") end, { desc = "Healthcheck" })
vim.keymap.set("n", "<leader>LM", function() vim.api.nvim_command("checkhealth mason") end, { desc = "Healthcheck Mason" })
vim.keymap.set("n", "<leader>LL", function() vim.api.nvim_command("checkhealth lsp") end, { desc = "Healthcheck LSP" })
vim.keymap.set("n", "<leader>LW", function() vim.api.nvim_command("checkhealth which-key") end, { desc = "Healthcheck Which-Key" })
vim.keymap.set("n", "<leader>Lc", function() vim.api.nvim_command("ConformInfo") end, { desc = "Conform Format Info" })
vim.keymap.set("n", "<leader>Lf", function()
  vim.api.nvim_command("LazyFormatInfo")
  vim.api.nvim_command("NoiceLast")
end, { desc = "Format Info" })
vim.keymap.set("n", "<leader>Lr", function()
  vim.api.nvim_command("LazyRoot")
  vim.api.nvim_command("NoiceLast")
end, { desc = "Roots Info" })

-- Mark management
vim.keymap.set("n", "md", function() Tricks.delete_marks_current_line()  end, { desc = "Del Mark Line" })
vim.keymap.set("n", "mD", function() vim.api.nvim_command("delmarks!") end, { desc = "Del All Marks" })

-- Escape regex characters
local function escape_regex(str)
  local matches = {
    ['%'] = '\\%',
    ['('] = '\\(',
    [')'] = '\\)',
    ['.'] = '\\.',
    ['%+'] = '\\+',
    ['%-'] = '\\-',
    ['*'] = '\\*',
    ['?'] = '\\?',
    ['['] = '\\[',
    [']'] = '\\]',
    ['^'] = '\\^',
    ['$'] = '\\$',
    ['{'] = '\\{',
    ['}'] = '\\}',
    ['|'] = '\\|',
  }
  return (str:gsub('.', matches))
end

vim.keymap.set("v", "<leader>ce", function()
  local csrow, cscol, cerow, cecol = Tricks.get_visual_selection_range()
  local text = Tricks.get_visual_selection()
  local escaped = escape_regex(text)

  -- indecies are 0-based against real rows and cols in an editor
  vim.api.nvim_buf_set_text(0, csrow - 1, cscol - 1, cerow - 1, cecol - 1, { escaped })
end, { desc = "Escape regex characters" })

-- Python helpers
vim.keymap.set("n", "<leader>cpv", function()
  Tricks.sidecart("python -m venv venv && source venv/bin/activate && pip install -r requirements.txt", true)
  local venv_path = "venv"
  vim.env.VIRTUAL_ENV = vim.fn.fnamemodify(venv_path, ":p")
  vim.env.PATH = vim.env.VIRTUAL_ENV .. "/bin:" .. vim.env.PATH
  LazyVim.notify("Activated venv: " .. vim.env.VIRTUAL_ENV)
  vim.api.nvim_command("LspRestart")
end, { desc = "Venv create" })

vim.keymap.set("n", "<leader>cpa", function()
  local venv_path = "venv"
  vim.env.VIRTUAL_ENV = vim.fn.fnamemodify(venv_path, ":p")
  vim.env.PATH = vim.env.VIRTUAL_ENV .. "/bin:" .. vim.env.PATH
  LazyVim.notify("Activated venv: " .. vim.env.VIRTUAL_ENV)
  vim.api.nvim_command("LspRestart")
end, { desc = "Venv activate" })

vim.keymap.set("n", "<leader>cpd", function()
  vim.env.VIRTUAL_ENV = nil
  -- Remove venv/bin from PATH
  local path = vim.env.PATH or ""
  path = path:gsub("[^:]+/venv/bin:?", "")
  vim.env.PATH = path
  LazyVim.notify("Deactivated venv")
end, { desc = "Venv deactivate" })

-- Go helpers
vim.keymap.set("n", "<leader>xc", function() Tricks.sidecart("golangci-lint run") end, { desc = "Run lint cli" })

-- Plantuml gui in the buffer dir
vim.keymap.set("n", "<leader>fop", function()
  local current_buffer_path = vim.fn.expand('%:h')
  vim.api.nvim_command("!plantuml -gui -theme sketchy -config $HOME/profile/plantuml/sketchy_config filedir " .. current_buffer_path .. "&")
end, { desc = "PlantUML Sketchy" })

vim.keymap.set("n", "<leader>foP", function()
  local current_buffer_path = vim.fn.expand('%:h')
  vim.api.nvim_command("!plantuml -gui -theme sketchy-outline -SComponentFontSize=14 -filedir " .. current_buffer_path .. "&")
end, { desc = "PlantUML Sketchy-outline" })

vim.keymap.set("n", "<leader>fof", function()
  local current_buffer_path = vim.fn.expand('%:h')
  vim.api.nvim_command("!open " .. current_buffer_path)
end, { desc = "Finder" })

vim.keymap.set("n", "<leader>fob", function()
  local current_buffer_path = vim.fn.expand('%:h')
  vim.api.nvim_command("!open -a '/Applications/Google Chrome.app' %")
end, { desc = "Browser" })

vim.keymap.set("n", "<leader>fyf", function()
  local current_buffer = vim.fn.expand('%:t')
  LazyVim.info(current_buffer)
  vim.fn.setreg("+", current_buffer, "c")
end, { desc = "Copy file name" })

vim.keymap.set("n", "<leader>fyF", function()
  local current_file = vim.fn.expand('%:p')
  local relative_path = Tricks.git_path(current_file)
  LazyVim.info(relative_path)
  vim.fn.setreg("+", relative_path, "c")
end, { desc = "Copy git file name" })

vim.keymap.set("n", "<leader>fyd", function()
  local current_dir = vim.fn.expand('%:p:h')
  local relative_path = Tricks.git_path(current_dir)
  LazyVim.info(relative_path)
  vim.fn.setreg("+", relative_path, "c")
end, { desc = "Copy git dir name to file" })

-- Terraform
vim.keymap.set("n", "<leader>cti", function() Tricks.sidecart("terraform init") end, { desc = "Terraform init" })
vim.keymap.set("n", "<leader>ctp", function() Tricks.sidecart("terraform plan") end, { desc = "Terraform plan" })
vim.keymap.set("n", "<leader>cta", function() Tricks.sidecart("terraform apply") end, { desc = "Terraform apply -auto-approve" })
vim.keymap.set("n", "<leader>ctwl", function() Tricks.sidecart("terraform workspace list") end, { desc = "Terraform workspace list" })
vim.keymap.set("n", "<leader>ctwd", function() Tricks.sidecart("terraform workspace select dev") end, { desc = "Terraform workspace select dev" })

vim.keymap.set({ "n", "i", "x" }, "<M-d>", function() vim.api.nvim_command("copy .\r") end, { desc = "Duplicate line" }) -- iterm2 remap from command+d

-- treesitter-context
vim.keymap.set("n", "<F1>", function()
  vim.api.nvim_command("TSContext toggle")
end, { desc = "Toggle context", silent = true })

vim.keymap.set("n", "[x", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-- visually select all content inside a markdown code block (between fences)
vim.keymap.set({ "v" }, "im", Beasts.select_fenced, { desc = "select code in markdown block", silent = true, noremap = true })

-- yank all content inside a markdown code block (between fences)
-- o - is operating mode, it goes to this mode after 'y/d/c' keys
vim.keymap.set({ "o" }, "im", Beasts.yank_fenced, { desc = "yank fenced", silent = true, noremap = true })

-- Jump to next/prev markdown code block
vim.keymap.set({ "n" }, "]s", Beasts.next_fenced, { desc = "Jump to next markdown code block", silent = true })
vim.keymap.set({ "n" }, "[s", Beasts.previous_fenced, { desc = "Jump to previous snippet in markdown", silent = true })

-- Copilot helpers
vim.keymap.set("n", "<leader>at", Beasts.touch_from_filename, { desc = "Touch a new file from filepath" })
vim.keymap.set("n", "<leader>aT", Beasts.touch_from_filename_list, { desc = "Touch files from list" })
vim.keymap.set("n", "<leader>ai", Beasts.new_file_or_append, { desc = "Insert to file" })
vim.keymap.set("n", "<leader>aI", Beasts.insert_many_fenced_to_files, { desc = "Insert all to files" })
vim.keymap.set("n", "<leader>aa", Beasts.copilot_chat_accept, { desc = "Accept suggestion" })
vim.keymap.set("n", "<leader>aA", Beasts.copilot_chat_accept_all, { desc = "Accept all suggestions" })
vim.keymap.set("n", "<leader>aj", Beasts.jump_to_lines, { desc = "Jump to lines" })
vim.keymap.set("n", "<leader>az", Beasts.copilot_response_zenmode, { desc = "Zen last response" })

-- stylua: ignore end
