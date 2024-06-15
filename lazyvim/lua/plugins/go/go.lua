return {
  "ray-x/go.nvim",
  lazy = true,
  -- ft = { "go", "gomod" },
  -- dependencies = { -- optional packages
  --   "ray-x/guihua.lua",
  -- },
  config = function()
    require("go").setup({ run_in_floaterm = true })
  end,
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  keys = {
    -- stylua: ignore start
    { "<leader>tgs", function () vim.api.nvim_command("GoTestFunc -s") end, desc = "Test Select Function" },
    { "<leader>tgr", function () vim.api.nvim_command("GoTestFunc -v -F") end, desc = "Test Function" },
    { "<leader>tgt", function () vim.api.nvim_command("GoTestFile -v -F") end, desc = "Test File" },
    { "<leader>tgT", function () vim.api.nvim_command("GoTest -F") end, desc = "Test All" },
    { "<leader>tgp", function () vim.api.nvim_command("GoTestPkg -F") end, desc = "Test Package" },
    { "<leader>tgd", function () vim.api.nvim_command("GoDebug --test") end, desc = "Debug Test" },
    { "<leader>tgg", function () vim.api.nvim_command("GinkgoFunc") end, desc = "Test Ginkgo Func" },

    { "<leader>cgt", function () vim.api.nvim_command("GoModTidy") end, desc = "Go Mod Tidy" },
    { "<leader>cgd", function () vim.api.nvim_command("GoDebug") end, desc = "Go Debug" },
    -- stylua: ignore end
  },
}
