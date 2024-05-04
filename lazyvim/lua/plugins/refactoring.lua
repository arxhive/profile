return {
  "ThePrimeagen/refactoring.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({ show_success_message = false })
  end,
}
