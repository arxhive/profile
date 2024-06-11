return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  version = "*",
  opts = {
    direction = "vertical",
    size = 100,
  },
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>bt", ":ToggleTerm<CR>", desc = "Toggle Term" },
  },
  -- init = function()
  --   require("toggleterm").setup()
  -- end,
}
