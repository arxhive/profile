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
      mode = { "n", "v" },
      { "<leader>a", group = "ai" },
      { "<leader>r", group = "refactor" },
      { "<leader>k", group = "kubernetes" },
      { "<leader>n", group = "noice" },
      { "<leader>L", group = "lazy" },
      { "<leader>tg", group = "ray-x go" },
      { "<leader>cg", group = "go" },
      { "<leader>cp", group = "python" },
      { "<leader>gm", group = "merge" },
      { "<leader>gh", group = "hunks" },
      { "<leader>fi", group = "ignore" },
      { "<leader>wS", group = "setup workspaces" },
      { "<leader>bo", group = "open in" },
      { "<leader>by", group = "yank" },
      { "<leader>2", hidden = true },
      { "<leader>3", hidden = true },
      { "<leader>4", hidden = true },
      { "<leader>5", hidden = true },
    },
  },
}
