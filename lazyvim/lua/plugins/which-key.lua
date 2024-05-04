return {
  "folke/which-key.nvim",
  event = function(_, event)
    return {}
  end,
  keys = { "<Leader>" },
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["<leader>r"] = { name = "+refactor" },
      ["<leader>h"] = { name = "+http client" },
    },
  },
}
