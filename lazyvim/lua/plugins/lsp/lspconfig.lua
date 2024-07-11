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
        vtsls = {
          autostart = false,
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
          },
        },
        eslint = {
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
        yamlls = {
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
      codelens = {
        enabled = false,
      },
    },
    -- doesn't work for some reasons, remap these keys from autocomand so far
    -- config = function(_, opts)
    --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = { "<leader>cc", false }
    -- end,
  },
}
