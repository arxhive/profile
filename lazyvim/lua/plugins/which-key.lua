return {
  "folke/which-key.nvim",
  -- event = function(_, event)
  --   return { "VeryLazy" }
  -- end,
  keys = { "<Leader>" },
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["<leader>a"] = { name = "+ai" },
      ["<leader>r"] = { name = "+refactor" },
      ["<leader>k"] = { name = "+kubernetes" },
      ["<leader>n"] = { name = "+noice" },
      ["<leader>L"] = { name = "+lazy" },
      ["<leader>tg"] = { name = "+ray-x go" },
      ["<leader>cg"] = { name = "+go" },
      ["<leader>cp"] = { name = "+python" },
      ["<leader>gm"] = { name = "+merge" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>fi"] = { name = "+ignore" },
      ["<leader>wS"] = { name = "+setup workspaces" },
    },
  },
}
