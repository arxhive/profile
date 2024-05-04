return {
  "nvim-lualine/lualine.nvim",
  -- event = "VeryLazy",
  event = "VimEnter",
  -- Tabline
  opts = function(_, opts)
    opts.tabline = {
      lualine_a = { "mode" },
      lualine_b = {},
      lualine_c = { { "filetype", icon_only = true }, { "filename", file_status = true, path = 1 } },
      lualine_x = {
        {
          function()
            if KINDLED then
              return ""
            else
              return ""
            end
          end,
        },
      },
      lualine_y = {
        -- display yaml/Kubernetes (~15ms)
        {
          function()
            if KINDLED then
              local schema = require("yaml-companion").get_buf_schema(0)
              if schema.result[1].name == "none" then
                return ""
              end
              return schema.result[1].name
            else
              return ""
            end
          end,
        },
        -- or rest client env (disabled because the rest client is very expensive to load: 50ms)
        -- {
        --   "rest",
        -- },
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
      lualine_z = {},
    }
  end,
}
