return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          mason = true,
        },
        ruff_lsp = {
          mason = true,
        },
        gopls = {
          mason = true,
        },
      },
    },
  },
}
