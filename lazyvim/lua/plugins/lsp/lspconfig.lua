return {
  {
    "neovim/nvim-lspconfig",
    event = function(_, event)
      return {}
      -- return { "LazyFile" }
    end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {
          autostart = false,
          filetypes = { "sh", "zsh" },
        },
        pyright = {
          autostart = false,
        },
        ruff_lsp = {
          autostart = false,
        },
        gopls = {
          autostart = false,
        },
        tsserver = {
          autostart = false,
        },
        omnisharp = {
          autostart = false,
        },
        marksman = {
          autostart = false,
        },
        helm_ls = {
          autostart = false,
        },
        lua_ls = {
          autostart = false,
        },
      },
      inlay_hints = {
        enabled = true,
      },
      document_highlight = {
        enabled = false,
      },
    },
  },
}
