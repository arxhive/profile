local M = {}

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

return M
