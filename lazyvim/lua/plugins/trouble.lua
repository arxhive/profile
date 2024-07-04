return {
  "folke/trouble.nvim",
  opts = {
    ---@type trouble.Window.opts
    win = {
      type = "float",
      size = { width = 0.8, height = 0.6 },
    },
    ---@type table<string, trouble.Action.spec>
    keys = {
      ["<cr>"] = "jump_close",
    },
  },
  keys = {
    { "<leader>cS", false },
    { "<leader>xQ", false },
  },
}
