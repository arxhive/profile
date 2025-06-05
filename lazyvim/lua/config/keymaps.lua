-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- or  ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua

-- special keys:  h keycodes
--             :  h key-notation
-- describe existing shortcuts:  verbose map <leader>..

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

-- Default Trouble lists
vim.keymap.del("n", "<leader>xt")
vim.keymap.del("n", "<leader>xT")
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

vim.keymap.set("n","<leader>xx", function() vim.api.nvim_command("Telescope diagnostics") end,  { desc = "Buffer Diagnostics"})
vim.keymap.set("n","<leader>xX", function() vim.api.nvim_command("Telescope diagnostics bufnr=0") end,  { desc = "Full Diagnostics"})

-- Lifehacks
vim.keymap.set("i", "©", "<ESC><ESC>", { desc = "Escape edit mode" }) -- used for iterm command mapping

vim.keymap.set({ "n", "x" }, "<Bslash>", ":")
vim.keymap.set({ "n", "i" }, "<F12>", function() vim.api.nvim_command("Kindle") end, { desc = "Turn on code mode"})

-- Terminal
vim.keymap.set({ "n", "i", "x" }, "<C-S-/>",
  function()
    local path = Tricks.rootdir()
    require("toggleterm").toggle(1, 100, path, "float", " Toggle Term root ")
  end, { desc = "Terminal (root)" })

vim.keymap.set({ "n", "i", "x" }, "<C-/>",
  function()
    local path = Tricks.refined("%:h:p")
    require("toggleterm").toggle(2, 100, path, "float", " Toggle Term cwd ")
  end, { desc = "Terminal (current folder)" }
)

-- Git aliases
vim.keymap.set("n", "<leader>gm", function() Tricks.sidecart("git fresh") end, { desc = "Merge from master" })

vim.keymap.set("n", "<leader>gR", function()
    local current_file = vim.fn.expand('%:p')
    local root_folder = Tricks.rootdir()
    root_folder = string.gsub(root_folder, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
    local relative_path = string.gsub(current_file, root_folder, '') -- remove the root folder path from the current file path
    relative_path = string.gsub(relative_path, "^/", "") -- remove the leading slash
    vim.api.nvim_command("!git reset-one '" .. relative_path .. "'")
    LazyVim.info(relative_path, { title = "Reverted to master:" })
end, { desc = "Revert file to master" })

vim.keymap.set("n", "<leader>gn",
  function()
    local new_branch_name = vim.fn.input("Branch name: ")
    if new_branch_name ~= "" then
      Tricks.sidecart("git fresh-b " .. new_branch_name)
    end
  end, { desc = "New Branch" })

  vim.keymap.set("n", "<leader>gMc", function() Tricks.sidecart("git merge --continue") end, { desc = "Merge continue" })
  vim.keymap.set("n", "<leader>gMa", function() Tricks.sidecart("git merge --abort") end, { desc = "Merge abort" })
  vim.keymap.set("n", "<leader>gt", function() Tricks.floatterm("git tree") end, { desc = "Git Tree" })
  vim.keymap.set("n", "<leader>gT", function() Tricks.floatterm("git full-tree") end, { desc = "Git Tree Detailed" })
  vim.keymap.set("n", "<leader>gB", function()
    local root_folder = Tricks.rootdir()
    root_folder = string.gsub(root_folder, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")

    local current_file_path = vim.fn.expand('%:p') -- get the full path of the current file
    local relative_path = string.gsub(current_file_path, root_folder, '') -- remove the root folder path from the current file path

    Tricks.silentterm("gh " .. relative_path)
  end, { desc = "Git Browse" }) -- my custom implementation instead of lazyvim snacks
  vim.keymap.set("n", "<leader>go", function() Tricks.floatterm("gco") end, { desc = "Checkout" })

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
-- vim.keymap.set("n", "<BS>", "i<C-w><Del><ESC>", { desc = "Delete a word" })

-- Navigation
-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape edit mode" })
-- vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape edit mode" })

-- Navigation experiments
-- vim.keymap.set("n", "1", "<C-W>h", {desc = "Left window"})
-- vim.keymap.set("n", "2", "<C-W>j", {desc = "Bottom window"})
-- vim.keymap.set("n", "3", "<C-W>k", {desc = "Top window"})
-- vim.keymap.set("n", "4", "<C-W>l", {desc = "Right window"})
-- vim.keymap.set({ "n", "v" }, "<Right>", "/\\u<CR>:nohlsearch<CR>", {desc = "Right window"})
-- vim.keymap.set({ "n", "v" }, "<Right>", "l/\\u<CR>h", {desc = "Next Upper"})
-- vim.keymap.set({ "n", "v" }, "<Left>", "/\\u<CR>NN", {desc = "Prev Upper"})
vim.keymap.set({ "n", "v" }, "]=", "f=w", {desc = "After ="})
vim.keymap.set({ "n", "v" }, "[=", "F=F b", {desc = "Before ="})
-- TestCamelCaseString := abc

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
vim.keymap.set({ "n" }, "<leader>rx", [[:%s///gI<Left><Left><Left><Left>]], { desc = "Regex Replace" })
-- :s - substitute in the specified lines
vim.keymap.set({ "v" }, "<leader>rx", [[:s///gI<Left><Left><Left><Left>]], { desc = "Regex Replace" })
-- vim.keymap.set({ "n", "v" }, "<leader>rS", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace selected by regex" })
vim.keymap.set("x", "<leader>rX", [[:s/\(.*\)/___\1___]], { desc = "Regex Suround" })

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
vim.keymap.set("n", "<leader>bd", function() vim.api.nvim_command("delmarks!") end, { desc = "Del Marks" })


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
vim.keymap.set("n", "<leader>cpv", function() Tricks.sidecart("python -m venv venv && source venv/bin/activate && pip install -r requirements.txt") end, { desc = "Venv create" })
vim.keymap.set("n", "<leader>cpa", function() Tricks.sidecart("source venv/bin/activate") end, { desc = "Venv activate" })
vim.keymap.set("n", "<leader>cpd", function() Tricks.sidecart("deactivate") end, { desc = "Venv deactivate" })

-- Go helpers
vim.keymap.set("n", "<leader>xc", function() Tricks.sidecart("golangci-lint run") end, { desc = "Run lint cli" })

-- Buffer helpers
vim.keymap.set("n", "<leader>fot", function()
    local current_file_path = vim.fn.expand('%:p') -- get the full path of the current file
    local relative_path = Tricks.cutPathStartingFromRoot(current_file_path)

    vim.api.nvim_command("!open -a 'Microsoft Edge' 'https://dev.azure.com/msazure/CloudNativeCompute/_git/aks-rp?path=" .. relative_path .. "'")
end, { desc = "TFS" })

vim.keymap.set("n", "<leader>fog", function()
    local current_file_path = vim.fn.expand('%:p') -- get the full path of the current file
    local relative_path = Tricks.cutPathStartingFromRoot(current_file_path)

    vim.api.nvim_command("!open -a 'Google Chrome' 'https://github.com/arxhive/profile/tree/main/" .. relative_path .. "'")
end, { desc = "Github" })

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
    local relative_path = Tricks.cutPathStartingFromRoot(current_file)
    LazyVim.info(relative_path)
    vim.fn.setreg("+", relative_path, "c")
end, { desc = "Copy relative file name" })

vim.keymap.set("n", "<leader>fyd", function()
    local current_dir = vim.fn.expand('%:p:h')
    local relative_path = Tricks.cutPathStartingFromRoot(current_dir)
    LazyVim.info(relative_path)
    vim.fn.setreg("+", relative_path, "c")
end, { desc = "Copy relative dir name" })

-- Terraform
vim.keymap.set("n", "<leader>cti", function() Tricks.sidecart("terraform init") end, { desc = "Terraform init" })
vim.keymap.set("n", "<leader>ctp", function() Tricks.sidecart("terraform plan") end, { desc = "Terraform plan" })
vim.keymap.set("n", "<leader>cta", function() Tricks.sidecart("terraform apply") end, { desc = "Terraform apply -auto-approve" })
vim.keymap.set("n", "<leader>ctwl", function() Tricks.sidecart("terraform workspace list") end, { desc = "Terraform workspace list" })
vim.keymap.set("n", "<leader>ctwd", function() Tricks.sidecart("terraform workspace select dev") end, { desc = "Terraform workspace select dev" })

vim.keymap.set({ "n", "i", "x" }, "<M-d>", function() vim.api.nvim_command("copy .\r") end, { desc = "Duplicate line" }) -- iterm2 remap from command+d

-- stylua: ignore end
