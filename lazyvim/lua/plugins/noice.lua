return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    presets = {
      bottom_search = false,
    },
    cmdline = {
      format = {
        search_down = {
          -- view = "cmdline",
          icon = "󰍉",
        },
        search_up = {
          -- view = "cmdline",
          icon = "󰍉",
        },
      },
    },
  },
  -- stylua: ignore
  keys = function()
          return {
            { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>m", function() require("noice").cmd("all") end, desc = "Messages" },
            { "<C-S-m>", function() require("noice").cmd("all") end, desc = "Messages" },
            { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<leader>nt", function() vim.cmd("Noice telescope") end, desc = "Noice telescope" },
          }
        end,
}
