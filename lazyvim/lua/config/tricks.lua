local M = {}
local term = require("toggleterm")

-- handle oil explorer prefix: "oil:///..."
function M.refined(path)
  local refined = vim.fn.expand(path)
  if string.find(refined, "oil") then
    refined = string.sub(refined, 6)
  -- hanndle any other special protocols
  elseif string.find(refined, "://") then
    refined = vim.uv.cwd()
  end

  return refined
end

-- opem toggleterm vertically and execute a command no changing focus
-- https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm.lua
-- @param cmd string
-- @param num number?
-- @param size number?
-- @param dir string?
-- @param direction string?
-- @param name string?
-- @param go_back boolean? whether or not to return to original window
-- @param open boolean? whether or not to open terminal window

function M.sidecart(cmd, fromRoot)
  local curDir = fromRoot and M.rootdir() or vim.fn.expand("%:h")
  term.exec(cmd, 3, 100, curDir, "vertical", "sidecart", true, true)
end

function M.floatterm(cmd)
  local curDir = vim.fn.expand("%:h") -- % for cwd
  term.exec(cmd, 4, 100, curDir, "float", " Toggle Term ", false, true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
end

function M.silentterm(cmd)
  local curDir = vim.fn.expand("%:h") -- % for cwd
  term.exec(cmd, 10, 100, curDir, "float", " Toggle Term ", true, false)
end

function M.activatetermcwd()
  local is_not_open = #require("toggleterm.terminal").get_all(true) == 0
  if is_not_open then
    Tricks.sidecart("")
  else
    vim.api.nvim_command("TermExec cmd=' cd %:p:h && clear' go_back=1 dir=%:p:h") -- space to avoid history
  end
end

-- simplified logic for root directory to avoid mess with root pattern after LSP start
function M.rootdir()
  -- simple git root detection
  return LazyVim.root.git()

  -- overcomplicated implementation, don't see use cases for that for now
  -- but FYI, this implementation is used by lualine
  -- return LazyVim.root.get({ normalize = true })
end

function M.rootdir_name()
  return string.match(LazyVim.root.git(), "([^/]+)$")
end

function M.cwd()
  local full_cwd = vim.fn.getcwd()
  return M.git_path(full_cwd)
end

function M.get_visual_selection_range()
  local _, csrow, cscol, cerow, cecol
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    -- if we are in visual mode use the live position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
    if mode == "V" then
      -- visual line doesn't provide columns
      cscol, cecol = 0, 999
    end
    -- exit visual mode
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end
  -- swap vars if needed
  if cerow < csrow then
    csrow, cerow = cerow, csrow
  end
  if cecol < cscol then
    cscol, cecol = cecol, cscol
  end

  return csrow, cscol, cerow, cecol
end

function M.get_visual_selection()
  -- this will exit visual mode
  -- use 'gv' to reselect the text
  local csrow, cscol, cerow, cecol = M.get_visual_selection_range()

  local lines = vim.fn.getline(csrow, cerow)
  -- local n = cerow-csrow+1
  local n = M.tbl_length(lines)
  if n <= 0 then
    return ""
  end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  return table.concat(lines, "\n")
end

function M.tbl_length(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

function M.get_last_yank()
  return vim.fn.getreg("0") -- reg: "0
  -- return vim.fn.getreg("+") -- this is a system clipboard
end

function M.inspect(item)
  vim.notify(vim.inspect(item))
end

-- remove local path to the root folder from the current file path
-- used for lualine cwd presentation for instance
function M.git_path_no_root(path)
  local root_dir = Tricks.rootdir()

  -- Escape special characters in root_folder for pattern matching. Since gsub is based on reges this is required for gsub to work correctly.
  local root_dir_escaped = string.gsub(root_dir, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")

  -- Remove root_folder from path
  -- The `^` is a Lua pattern anchor that matches only the beginning of the string.
  -- When used in combination with `string.gsub`, it ensures that the substitution only occurs if `root_dir_escaped` is found at the very start of the `path` string, not in the middle.
  local path_part_after_root = string.gsub(path, "^" .. root_dir_escaped, "")

  return path_part_after_root
end

function M.git_path(path)
  local root_dir = Tricks.rootdir()
  -- last part of the root_dir
  local repo_dir_name = string.match(root_dir, "([^/]+)$")

  -- Escape special characters in root_folder for pattern matching. Since gsub is based on reges this is required for gsub to work correctly.
  local root_dir_escaped = string.gsub(root_dir, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")

  -- Remove root_folder from path
  -- The `^` is a Lua pattern anchor that matches only the beginning of the string.
  -- When used in combination with `string.gsub`, it ensures that the substitution only occurs if `root_dir_escaped` is found at the very start of the `path` string, not in the middle.
  local path_part_after_root = string.gsub(path, "^" .. root_dir_escaped, "")

  return repo_dir_name .. path_part_after_root
end

function M.to_quickfix()
  -- Get information about the current line
  local line_number = vim.fn.line(".") -- Get the current line number
  local filename = vim.fn.expand("%:p") -- Get the full path of the current file
  local line_text = vim.fn.getline(".") -- Get the text of the current line

  -- Create a quickfix entry for the current line
  local qf_entry = {
    filename = filename,
    lnum = line_number,
    text = line_text,
  }

  -- Get the current quickfix list
  local qf_list = vim.fn.getqflist()

  -- Append the new entry to the list
  table.insert(qf_list, qf_entry)

  -- Set the updated quickfix list
  vim.fn.setqflist(qf_list, "r")

  return vim.inspect(qf_entry)
end

function M.remove_from_quickfix()
  -- Get the current line number
  local line_number = vim.fn.line(".")

  -- Get the current quickfix list
  local qf_list = vim.fn.getqflist()

  -- Filter out the entry matching the current line number
  local updated_qf_list = {}
  for _, entry in ipairs(qf_list) do
    if entry.lnum ~= line_number then
      table.insert(updated_qf_list, entry)
    end
  end

  -- Set the updated quickfix list
  vim.fn.setqflist(updated_qf_list, "r")
end

function M.clear_quickfix()
  vim.fn.setqflist({}, "r")
end

function M.delete_marks_current_line()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local deleted_marks = {}

  -- Add file marks (lowercase marks)
  for c = string.byte("a"), string.byte("z") do
    local mark_pos = vim.api.nvim_buf_get_mark(0, string.char(c))
    if mark_pos[1] == current_line then
      table.insert(deleted_marks, string.char(c))
      vim.cmd("delmarks " .. string.char(c))
    end
  end

  -- Add global marks (uppercase marks)
  for c = string.byte("A"), string.byte("Z") do
    local mark_pos = vim.api.nvim_buf_get_mark(0, string.char(c))
    if mark_pos[1] == current_line then
      table.insert(deleted_marks, string.char(c))
      vim.cmd("delmarks " .. string.char(c))
    end
  end

  if #deleted_marks > 0 then
    LazyVim.notify("Mark is deleted: " .. table.concat(deleted_marks, ", "), { title = "Marks" })
  end
end

return M
