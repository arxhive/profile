return {
  "chrisgrieser/nvim-scissors",
  lazy = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    snippetDir = "~/profile/lazyvim/lua/snippets",
  },
  keys = {
    -- stylua: ignore start
    { "<leader>Sa", function() require("scissors").addNewSnippet() end, desc = "Snippet Add", mode = { "n", "x" } },
    { "<leader>Se", function() require("scissors").editSnippet() end, desc = "Snippet Edit", },
  },
}
