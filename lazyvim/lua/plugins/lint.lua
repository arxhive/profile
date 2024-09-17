return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013/line-length", "MD024", "MD033", "--" },
        },
      },
    },
  },
}
