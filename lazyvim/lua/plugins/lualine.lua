return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- Tabline
  opts = function(_, opts)
    local catppuccin = require("lualine.themes.catppuccin")
    insert_mode_color = "#F5C2E7"
    catppuccin.insert.a.bg = insert_mode_color
    catppuccin.insert.b.fg = insert_mode_color
    catppuccin.command.a.bg = insert_mode_color
    catppuccin.command.b.fg = insert_mode_color

    -- firenvim settings
    if vim.g.started_by_firenvim == true then
      opts.tabline = { lualine_a = { "mode" } }
      opts.sections = {}
      opts.options = {
        section_separators = { left = "", right = "" },
      }
    else
      opts.options = {
        theme = catppuccin,
      }

      -- normal settings
      opts.tabline = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { { "filetype", icon_only = true }, { "filename", file_status = true, path = 1 } },
        lualine_x = {
          -- display yaml/Kubernetes (~15ms)
          function()
            if package.loaded["yaml-companion"] then
              local schema = require("yaml-companion").get_buf_schema(0)
              if schema.result[1].name == "none" then
                return ""
              end
              return schema.result[1].name
            else
              return ""
            end
          end,
          -- function()
          --   if KINDLED then
          --     return ""
          --   else
          --     return ""
          --   end
          -- end,
        },
        lualine_y = {
          function()
            return require("lsp-progress").progress()
          end,
        },
        lualine_z = {
          function()
            local buf = vim.api.nvim_buf_get_name(0)
            print(buf)
            if buf:match("toggleterm") then
              return "term"
            elseif buf:match("copilot") then
              return "copilot"
            elseif buf:match("filesystem") then
              return "explorer"
            else
              return ""
            end
          end,
        },
      }

      -- Status line
      local icons = require("lazyvim.config").icons
      opts.sections = {
        lualine_a = {},
        lualine_b = { "branch" },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Snacks.util.color("Statement", "guifg")
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Snacks.util.color("Constant", "guifg")
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Snacks.util.color("Debug", "guifg")
          },
        },
        lualine_y = {
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {},
      }
    end
  end,
}
