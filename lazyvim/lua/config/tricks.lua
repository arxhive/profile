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
  return LazyVim.root.git()
end

function M.rootdir_name()
  return string.match(LazyVim.root.git(), "([^/]+)$")
end

function M.cwd()
  local full_cwd = vim.fn.getcwd()
  return M.gitPath(full_cwd)
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
function M.gitPathNoRoot(path)
  local root_folder = Tricks.rootdir()
  root_folder = string.gsub(root_folder, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
  local path_part_after_root = string.gsub(path, root_folder, "")
  return path_part_after_root
end

function M.gitPath(path)
  local root_folder = Tricks.rootdir()
  root_folder = string.gsub(root_folder, "([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
  local repo_folder_name = string.match(root_folder, "([^/]+)$")
  local path_part_after_root = string.gsub(path, root_folder, "")
  return repo_folder_name .. path_part_after_root
end

return M
