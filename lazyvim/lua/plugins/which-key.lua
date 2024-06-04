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
      ["<leader>a"] = { name = "+ai" },
      ["<leader>r"] = { name = "+refactor" },
      ["<leader>k"] = { name = "+kubernetes" },
      ["<leader>n"] = { name = "+noice" },
      ["<leader>tg"] = { name = "+ray-x go" },
      ["<leader>cg"] = { name = "+ray-x go" },
      ["<leader>gh"] = { name = "+hunks" },

      ["<leader>2"] = { name = "" },
      ["<leader>3"] = { name = "" },
      ["<leader>4"] = { name = "" },
      ["<leader>5"] = { name = "" },
      ["<leader>H"] = { name = "" },
      ["<leader>K"] = { name = "" },
      ["<leader>L"] = { name = "" },

      ["<leader>`"] = { name = "" },
    },
  },
}
