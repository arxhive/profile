return {
  "ray-x/go.nvim",
  lazy = false,
  ft = { "go", "gomod" },
  -- dependencies = { -- optional packages
  --   "ray-x/guihua.lua",
  -- },
  config = function()
    require("go").setup({ run_in_floaterm = true })
  end,
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  keys = {
    -- stylua: ignore start
    { "<leader>tgs", function () vim.cmd("GoTestFunc -s") end, desc = "Test Select Function" },
    { "<leader>tgr", function () vim.cmd("GoTestFunc -v -F") end, desc = "Test Function" },
    { "<leader>tgt", function () vim.cmd("GoTestFile -v -F") end, desc = "Test File" },
    { "<leader>tgT", function () vim.cmd("GoTest -F") end, desc = "Test All" },
    { "<leader>tgp", function () vim.cmd("GoTestPkg -F") end, desc = "Test Package" },
    { "<leader>tgd", function () vim.cmd("GoDebug --test") end, desc = "Debug Test" },
    { "<leader>tgg", function () vim.cmd("GinkgoFunc") end, desc = "Test Ginkgo Func" },

    { "<leader>cgt", function () vim.cmd("GoModTidy") end, desc = "Go Mod Tidy" },
    { "<leader>cgd", function () vim.cmd("GoDebug") end, desc = "Go Debug" },
    -- stylua: ignore end
  },
}
