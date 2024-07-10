return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  version = "*",
  opts = {
    direction = "vertical",
    size = 100,
    shade_terminals = false,
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      -- https://github.com/akinsho/toggleterm.nvim/blob/cd55bf6aab3f88c259fa29ea86bbdcb1a325687d/lua/toggleterm/colors.lua#L95
      Normal = {
        guibg = "#181825", -- mantle cattpuccin
      },
      -- NormalFloat = {
      --   link = 'Normal'
      -- },
      -- FloatBorder = {
      --   guifg = "<VALUE-HERE>",
      --   guibg = "<VALUE-HERE>",
      -- },
    },
  },
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>bt", ":ToggleTerm<CR>", desc = "Toggle Term" },
    {
      "<leader>bc",
      function()
        -- 3 <C-l> just in case if I have more than 1 vsplit open
        -- i is either insert mode or alias iexit=exit
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l><C-l><C-l>i", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("exit<CR>", true, false, true), "m", false)
      end,
      desc = "Close Toggle Term",
    },
  },
}
