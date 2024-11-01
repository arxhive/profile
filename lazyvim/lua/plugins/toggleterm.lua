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
      NormalFloat = {
        -- guibg = "#181825",
        -- link = 'Normal'
      },
      FloatBorder = {
        guifg = "#1E1E2E", -- base cattpuccin
        guibg = "#1E1E2E",
      },
    },
    float_opts = {
      border = "single",
      title_pos = "center",
      winblend = 0,
      width = function()
        return math.ceil(vim.o.columns * 1)
      end,
      height = function()
        return math.ceil(vim.o.lines * 1)
      end,
    },
    -- close_on_exit = true,
  },
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>bt", ":ToggleTerm dir=%:p:h<CR>", desc = "ToggleTerm cwd" },
    {
      "<leader>wt",
      function()
        is_open = #require("toggleterm.terminal").get_all(true) > 0
        if is_open then
          vim.api.nvim_command("TermExec cmd=date go_back=0")
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i<BS>", true, false, true), "m", false)
        else
          vim.api.nvim_command("ToggleTerm dir=%:p:h")
        end
      end,
      desc = "ToggleTerm Focus",
    },
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
