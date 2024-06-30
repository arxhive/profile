return {
  {
    "nvimtools/none-ls.nvim",
    enabled = false,
    lazy = true,
    event = function(_, event)
      return {}
    end,
    opts = function(_, opts)
      local null_ls = require("null-ls")
      null_ls.disable({ name = "spell", method = "completion" })
      null_ls.disable({ name = "gopls" })
    end,
  },
}
