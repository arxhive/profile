return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  version = "*",
  opts = {
    direction = "vertical",
    size = 100,
  },
  cmd = { "ToggleTerm", "TermExec" },
  -- init = function()
  --   require("toggleterm").setup()
  -- end,
}
