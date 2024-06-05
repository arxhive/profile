-- oil opts are configured in init.lua
return {
  "stevearc/oil.nvim",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  keys = {
    { "<leader>ww", function() require("oil").open() end, desc = "Oil (cwd)" },
    { "<leader>wW", function() require("oil").open(LazyVim.root()) end, desc = "Oil (root)" },
    { "<leader>o", function() require("oil").open() end, desc = "Oil (cwd)" },
    { "<leader>O", function() require("oil").open(LazyVim.root()) end, desc = "Oil (root)" },
  },
}
