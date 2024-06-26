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
    {
      "<leader>bc",
      function()
        -- i is either insert mode or alias iexit=exit 
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l>i", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("exit<CR>", true, false, true), "m", false)
      end,
      desc = "Close Toggle Term",
    },
  },
  -- init = function()
  --   require("toggleterm").setup()
  -- end,
}
