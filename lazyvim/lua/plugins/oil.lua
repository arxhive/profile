-- oil opts are configured in init.lua
return {
  "stevearc/oil.nvim",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  keys = {
    { "<leader>o", function() require("oil").open(vim.fn.getcwd()) end, desc = "Oil (cwd)" },
    { "<leader>O", function() require("oil").open(LazyVim.root()) end, desc = "Oil (root)" },
  },
}
