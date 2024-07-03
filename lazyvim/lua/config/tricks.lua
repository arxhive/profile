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
function M.sidecart(cmd)
  --- @param cmd string
  --- @param num number?
  --- @param size number?
  --- @param dir string?
  --- @param direction string?
  --- @param name string?
  --- @param go_back boolean? whether or not to return to original window
  --- @param open boolean? whether or not to open terminal window

  term.exec(cmd, 0, 100, "%", "vertical", "sidecart", true, true)
end

-- simplified logic for root directory to avoid mess with root pattern after LSP start
function M.rootdir()
  return LazyVim.root.git()
end

return M
