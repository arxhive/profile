return {
  "folke/trouble.nvim",
  opts = {
    ---@type trouble.Window.opts
    win = {
      type = "float",
    },
    ---@type table<string, trouble.Action.spec>
    keys = {
      ["<cr>"] = "jump_close",
    },
  },
}
