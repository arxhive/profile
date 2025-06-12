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
      -- this config makes sure mason installs the servers
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
        ts_ls = {
          enabled = false,
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
        jsonls = {
          autostart = false,
          -- Doesn't work for some reasons. Use manual  mapping from autocmds.lua instead
          -- filetypes = { "json", "jsonc", "json.tpl", "tpl", "gotpl" },
        },
        -- nvim-jdtls is a wrapper around Eclipse JDT for nvim, similarly to lspconfig itself
        jdtls = {
          autostart = false, -- doesn't work
        },
        terraformls = {
          autostart = false,
        },
        bicep = {
          autostart = false, -- managed by Kindle
          enabled = true,
        },
        metals = {
          autostart = false, -- managed by Kindle
          keys = {
            {
              "<leader>cme",
              function()
                require("telescope").extensions.metals.commands()
              end,
              desc = "Metals commands",
            },
            {
              "<leader>cmc",
              function()
                require("metals").compile_cascade()
              end,
              desc = "Metals compile cascade",
            },
            {
              "<leader>cmh",
              function()
                require("metals").hover_worksheet()
              end,
              desc = "Metals hover worksheet",
            },
          },
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
