return {
  "folke/which-key.nvim",
  -- event = function(_, event)
  --   return { "VeryLazy" }
  -- end,
  keys = { "<Leader>" },
  opts = {
    icons = {
      mappings = false,
    },
    delay = 400,
    plugins = { spelling = false },
    spec = {
      { "<leader>a", group = "ai", mode = { "n", "v", "x" } },
      { "<leader>r", group = "refactor" },
      { "<leader>k", group = "kubernetes" },
      { "<leader>n", group = "noice" },
      { "<leader>L", group = "lazy" },
      { "<leader>S", group = "scissors", mode = { "n", "v", "x" } },
      { "<leader>tg", group = "ray-x go" },
      { "<leader>cg", group = "go" },
      { "<leader>cp", group = "python" },
      { "<leader>gm", group = "merge" },
      { "<leader>gh", group = "hunks" },
      { "<leader>fi", group = "ignore" },
      { "<leader>wS", group = "setup workspaces" },
      { "<leader>bo", group = "open in" },
      { "<leader>by", group = "yank" },
      { "<leader>si", group = "infra" },
      { "<leader>2", hidden = true },
      { "<leader>3", hidden = true },
      { "<leader>4", hidden = true },
      { "<leader>5", hidden = true },
      { "<leader>wT", hidden = true },
    },
  },
}
