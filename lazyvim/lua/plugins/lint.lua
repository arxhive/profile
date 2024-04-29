return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "MD024", "MD033", "--" },
        },
      },
    },
  },
}
