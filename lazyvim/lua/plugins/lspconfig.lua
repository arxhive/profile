return {
  {
    "neovim/nvim-lspconfig",
    event = function(_, event)
      return {}
    end,
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
