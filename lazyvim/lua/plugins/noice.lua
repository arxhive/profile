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
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<leader>snt", function() vim.cmd("Noice telescope") end, desc = "Noice telescope" },
          }
        end,
}
