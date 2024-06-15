return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    presets = {
      bottom_search = false,
      long_message_to_split = false,
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
    messages = {
      view = "mini",
      view_error = "mini",
      view_warn = "mini",
    },
    notify = {
      view = "mini",
    },
    views = {
      cmdline_popup = {
        border = {
          style = "solid",
        },
      },
      popup = {
        border = {
          style = "solid",
        },
      },
    },
  },
  -- stylua: ignore
  keys = function()
    return {
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>l", function() require("noice").cmd("last") end, desc = "Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>m", function() require("noice").cmd("all") end, desc = "Messages" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>nt", function() vim.cmd("Noice telescope") end, desc = "Noice telescope" },
      { "<leader>fp",
        function()
          local path = vim.fn.expand("%:p")
          LazyVim.info(path)
          require("noice").cmd("last")
          vim.api.nvim_command("silent !echo '" .. path .. "' | pbcopy")
        end, desc = "Print current file path" },
    }
  end
,
}
