return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
    -- Tabline
    opts = function(_, opts)
      opts.tabline = { 
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = { { 'filename', file_status = true, path = 1  }},
        lualine_x = {},
        lualine_y = {
        {
          function()
            local schema = require("yaml-companion").get_buf_schema(0)
            if schema.result[1].name == "none" then
              return ""
            end
            return schema.result[1].name
          end,
        }
      },
      lualine_z = {}
    }
      
    -- Status line
    opts.sections.lualine_a = {}
    opts.sections.lualine_z = {}
  end,
}

