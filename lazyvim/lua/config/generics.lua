local tricks = require("config.tricks")

-- Code runner
vim.keymap.set("n", "<leader>br", function()
  local current_file = vim.fn.expand("%:p")
  if string.find(current_file, ".py") then
    tricks.sidecart("python " .. current_file)
  elseif string.find(current_file, ".sh") then
    tricks.sidecart("source " .. current_file)
  elseif string.find(current_file, ".cs") then
    tricks.sidecart("dotnet run")
  elseif string.find(current_file, ".js") or string.find(current_file, ".ts") then
    tricks.sidecart("node" .. current_file)
  elseif string.find(current_file, ".go") then
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
vim.keymap.set("n", "<leader>bb", function()
  local current_file = vim.fn.expand("%:p")

  if string.find(current_file, ".py") then
    tricks.sidecart("pip install -r requirements.txt")
  elseif string.find(current_file, ".cs") then
    tricks.sidecart("dotnet build")
  elseif string.find(current_file, ".js") or string.find(current_file, ".ts") then
    tricks.sidecart("npm install")
  elseif string.find(current_file, ".go") then
    tricks.sidecart("go build")
  else
    LazyVim.info("Cannot build")
  end
end, { desc = "Build" })

-- Run Tests in CLI
vim.keymap.set("n", "<leader>tc", function()
  local current_file = vim.fn.expand("%:p")

  if string.find(current_file, ".py") then
    LazyVim.info("Cannot test py TBD")
  elseif string.find(current_file, ".cs") then
    LazyVim.info("Cannot test dotnet TBD")
  elseif string.find(current_file, ".js") or string.find(current_file, ".ts") then
    tricks.sidecart("jest .")
    -- tricks.sidecart("npm run test .") -- TODO: test it
  elseif string.find(current_file, ".go") then
    tricks.sidecart("go test .")
  else
    LazyVim.info("Cannot run tests")
  end
end, { desc = "Run Tests CLI" })

vim.keymap.set("n", "<leader>tC", function()
  local current_file = vim.fn.expand("%:p")

  if string.find(current_file, ".py") then
    LazyVim.info("Cannot test py TBD")
  elseif string.find(current_file, ".cs") then
    LazyVim.info("Cannot test dotnet TBD")
  elseif string.find(current_file, ".js") or string.find(current_file, ".ts") then
    tricks.sidecart("jest ./...")
    -- tricks.sidecart("npm run test ./...") -- TODO: test it
  elseif string.find(current_file, ".go") then
    tricks.sidecart("go test ./...")
  else
    LazyVim.info("Cannot run tests")
  end
end, { desc = "Run All Tests CLI" })
