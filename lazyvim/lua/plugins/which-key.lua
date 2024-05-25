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
      ["<leader>k"] = { name = "+kubernetes" },
      ["<leader>gh"] = { name = "Git History" },

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
