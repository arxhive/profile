return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- Tabline
  opts = function(_, opts)
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
      lualine_z = {},
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
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      },
      lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = LazyVim.ui.fg("Statement"),
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = LazyVim.ui.fg("Constant"),
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = LazyVim.ui.fg("Debug"),
        },
      },
      lualine_y = {
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {},
    }
  end,
}
