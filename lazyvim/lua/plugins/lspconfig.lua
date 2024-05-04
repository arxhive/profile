return {
  {
    "neovim/nvim-lspconfig",
    event = function(_, event)
      return { "LazyFile" }
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        ruff_lsp = {},
        gopls = {},
      },
    },
  },
}
