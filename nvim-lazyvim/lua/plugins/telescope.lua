return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
        },
      },
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    module = "telescope._extensions.luasnip",
  },
}
