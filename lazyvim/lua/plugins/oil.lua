-- oil opts are configured in init.lua
return {
  "stevearc/oil.nvim",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  keys = {
    { "<leader>ww", function() require("oil").open() end, desc = "Oil open" },
    { "<leader>o", function() require("oil").open() end, desc = "Oil open" },
  },
}
