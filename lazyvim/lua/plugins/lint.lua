return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", vim.fn.expand("~/profile/lazyvim/lua/linters/.markdownlint-cli2.yaml"), "--" },
        },
      },
    },
  },
}
