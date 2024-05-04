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
        {
          function()
            if KINDLED then
              return ">_"
            else
              return ""
            end
          end,
        },
      },
      lualine_y = {
        -- display yaml/Kubernetes (~15ms)
        -- {
        --   function()
        --     local schema = require("yaml-companion").get_buf_schema(0)
        --     if schema.result[1].name == "none" then
        --       return ""
        --     end
        --     return schema.result[1].name
        --   end,
        -- },
        -- or rest client env (disabled because the rest client is very expensive to load: 50ms)
        -- {
        --   "rest",
        -- },
      },
      lualine_z = {},
    }

    -- Status line
    opts.sections.lualine_a = {}
    opts.sections.lualine_z = {}
  end,
}
