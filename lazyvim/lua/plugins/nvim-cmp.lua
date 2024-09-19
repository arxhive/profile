return {
  {
    -- disable default <tab> and <s-tab> behavior in LuaSnip
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "L3MON4D3/LuaSnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      cmp.setup.buffer({
        -- Dont suggest Text from nvm_lsp and buffer sources
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
          },
          {
            name = "buffer",
            entry_filter = function(entry, ctx)
              return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
            end,
            option = {
              get_bufnrs = function()
                return {}
              end,
            },
          },
          -- Warning: load time of path if pretty slow ~200ms
          {
            name = "path",
          },
        }),
      })
      -- opts.sources = cmp.config.sources({
      --   { name = "lazydev" },
      --   { name = "snippets" },
      --   { name = "nvim_lsp" },
      --   { name = "path" },
      --   { name = "copilot" },
      -- })

      -- require("cmp").setup.buffer({ sources = cmp.config.sources })

      -- print configures sources
      -- local sources = opts.sources
      -- LazyVim.info("sources: ", sources)
      -- for i = #sources, 1, -1 do
      --   LazyVim.info(sources[i].name)
      --   if sources[i].name == "buffer" then
      --     LazyVim.info("found buffer source!!!")
      --     table.remove(sources, i)
      --   end
      -- end
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      -- setup tab complete for cmp and luasnip
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          -- jump between snippet args without luasnip
          -- elseif vim.snippet.active({ direction = 1 }) then
          --   vim.schedule(function()
          --     vim.snippet.jump(1)
          --   end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          -- jump back without luasnip
          -- elseif vim.snippet.active({ direction = -1 }) then
          --   vim.schedule(function()
          --     vim.snippet.jump(-1)
          --   end)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
          cmp.abort()
          fallback()
        end),
        -- fallback to apply Copilot ghost text
        ["<S-CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end),
        -- improved navigation for next/prev item in the menu
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      -- cmdline setup
      local cmdLineMapping = {

        ["<Tab>"] = {
          c = function()
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              cmp.complete()
            end
          end,
        },
        ["<Up>"] = {
          c = function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end,
        },
        ["<Down>"] = {
          c = function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end,
        },
        ["<C-k>"] = {
          c = function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end,
        },
        ["<C-j>"] = {
          c = function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end,
        },
      }

      -- `:` cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), cmdLineMapping),
        sources = cmp.config.sources({
          { name = "path" },
          -- { name = "cmdline_history" },
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline("/", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), cmdLineMapping),
      })

      -- `?` cmdline setup.
      cmp.setup.cmdline("?", {
        mapping = vim.tbl_extend("force", cmp.mapping.preset.cmdline(), cmdLineMapping),
      })
    end,
  },
}
