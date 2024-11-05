local tricks = require("config.tricks")

-- Code runner
vim.keymap.set("n", "<leader>br", function()
  local current_file = vim.fn.expand("%:p")
  local ext = current_file:match("^.+(%..+)$")

  local run = function()
    if ext == ".py" then
      tricks.sidecart("python " .. current_file)
    elseif ext == ".sh" then
      tricks.sidecart("source " .. current_file)
    elseif ext == ".cs" then
      tricks.sidecart("dotnet run")
    elseif ext == ".js" or ext == ".ts" or ext == ".tsx" then
      tricks.sidecart("npm run start")
    elseif ext == ".mjs" or ext == ".cjs" then
      tricks.sidecart("node " .. current_file)
    elseif ext == ".go" then
      tricks.sidecart("go run " .. current_file)
    else
      LazyVim.info("Cannot run")
    end
  end

  -- close termnial if open for safe re-run
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l><C-l><C-l>i<C-c>", true, false, true), "m", false)
  vim.schedule(function()
    run()
  end)

  -- more correct approach but not working:
  -- vim.schedule(function()
  --   local cur_sidecart = vim.fn.expand("%:p")
  --   if string.find(cur_sidecart, "#toggleterm") then
  --     -- close it
  --     -- vim.schedule(function()
  --     --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "m", false)
  --     -- end)
  --       -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i<C-c>", true, false, true), "m", false)
  --         -- run()
  --     -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("exit<CR>", true, false, true), "m", false)
  --     -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>bc", true, false, true), "m", false)
  --     -- require("toggleterm").exec("exit", 0, 100, "%", "vertical", "sidecart", true, true)
  --   else
  --     run()
  --   end
  -- end)
end, { desc = "Run code" })

vim.keymap.set("n", "<leader>bl", function()
  tricks.activatetermcwd()

  local trim_spaces = true
  require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = 0 })
end, { desc = "Toggleterm line" })

vim.keymap.set("x", "<leader>bl", function()
  tricks.activatetermcwd()

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
  elseif ext == ".js" or ext == ".ts" or ext == ".tsx" or ext == ".mjs" or ext == ".cjs" then
    tricks.sidecart("npm install && npm run build")
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

  tricks.activatetermcwd()

  if ext == ".py" then
    LazyVim.info("Cannot test py TBD")
  elseif ext == ".cs" then
    LazyVim.info("Cannot test dotnet TBD")
  elseif ext == ".js" or ext == ".ts" or ext == ".tsx" or ext == ".mjs" or ext == ".cjs" then
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

  tricks.activatetermcwd()

  if ext == ".py" then
    LazyVim.info("Cannot test py TBD")
  elseif ext == ".cs" then
    LazyVim.info("Cannot test dotnet TBD")
  elseif ext == ".js" or ext == ".ts" or ext == ".tsx" or ext == ".mjs" or ext == ".cjs" then
    tricks.sidecart("npm run test")
  elseif ext == ".go" then
    tricks.sidecart("richgo test ./... -v")
  else
    LazyVim.info("Cannot run tests")
  end
end, { desc = "Run All Tests CLI" })
