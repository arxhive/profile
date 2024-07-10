local tricks = require("config.tricks")

-- Code runner
vim.keymap.set("n", "<leader>br", function()
  local current_file = vim.fn.expand("%:p")
  local ext = current_file:match("^.+(%..+)$")

  if ext == ".py" then
    tricks.sidecart("python " .. current_file)
  elseif ext == ".sh" then
    tricks.sidecart("source " .. current_file)
  elseif ext == ".cs" then
    tricks.sidecart("dotnet run")
  elseif ext == ".js" or ext == ".ts" then
    tricks.sidecart("npm run start")
    -- tricks.sidecart("node " .. current_file)
  elseif ext == ".go" then
    tricks.sidecart("go run " .. current_file)
  else
    LazyVim.info("Cannot run")
  end
end, { desc = "Run code" })

vim.keymap.set("n", "<leader>bl", function()
  local trim_spaces = true
  require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = 0 })
end, { desc = "Toggleterm line" })

vim.keymap.set("x", "<leader>bl", function()
  local trim_spaces = true
  require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = 0 })
end, { desc = "Toggleterm selected" })

-- Builder
vim.keymap.set("n", "<leader>bi", function()
  local current_file = vim.fn.expand("%:p")
  local ext = current_file:match("^.+(%..+)$")

  if ext == ".py" then
    tricks.sidecart("pip install -r requirements.txt")
  elseif ext == ".cs" then
    tricks.sidecart("dotnet build")
  elseif ext == ".js" or ext == ".ts" then
    tricks.sidecart("npm install && npm build")
  elseif ext == ".go" then
    tricks.sidecart("go build")
  else
    LazyVim.info("Cannot build")
  end
end, { desc = "Install and Build" })

-- Run Tests in CLI
vim.keymap.set("n", "<leader>tc", function()
  local current_file = vim.fn.expand("%:p")
  local ext = current_file:match("^.+(%..+)$")

  if ext == ".py" then
    LazyVim.info("Cannot test py TBD")
  elseif ext == ".cs" then
    LazyVim.info("Cannot test dotnet TBD")
  elseif ext == ".js" or ext == ".ts" then
    tricks.sidecart("npm run test " .. current_file)
  elseif ext == ".go" then
    tricks.sidecart("richgo test . -v")
  else
    LazyVim.info("Cannot run tests")
  end
end, { desc = "Run Tests CLI" })

vim.keymap.set("n", "<leader>tC", function()
  local current_file = vim.fn.expand("%:p")
  local ext = current_file:match("^.+(%..+)$")

  if ext == ".py" then
    LazyVim.info("Cannot test py TBD")
  elseif ext == ".cs" then
    LazyVim.info("Cannot test dotnet TBD")
  elseif ext == ".js" or ext == ".ts" then
    tricks.sidecart("npm run test")
  elseif ext == ".go" then
    tricks.sidecart("richgo test ./... -v")
  else
    LazyVim.info("Cannot run tests")
  end
end, { desc = "Run All Tests CLI" })
