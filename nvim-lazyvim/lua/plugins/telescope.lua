return {
  {
    "benfowler/telescope-luasnip.nvim",
    lazy = true,
    module = "telescope._extensions.luasnip",
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "public/docs",
        },
      },
    },
  },
}
