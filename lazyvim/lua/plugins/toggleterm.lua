return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  version = "*",
  opts = {
    direction = "vertical",
    size = 100,
    shade_terminals = false,
    start_in_insert = false, -- use false to avoid conflicts with a custom nvim_feedkeys function on_open
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
    on_open = function(term)
      -- custom insert mode on open that work more stable than start_in_insert option
      vim.schedule(function()
        -- use to prevent jumping into insert mode before term initialiation for some use cases where I execute automatically execute a term command (Tricks.sidecart for example)
        if vim.bo.filetype == "toggleterm" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>i", true, false, true), "n", false)
        end
      end)
      -- "t" is a Terminal Mode
      -- this callback is used to close any toggleterm buffer on <Tab>
      vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Tab>", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })
      -- or use "q" in normal mode to close
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    close_on_exit = true,
  },
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>bt", ":ToggleTerm dir=%:p:h<CR>", desc = "Term Toggle cwd" },
    { "<leader>bT", ":ToggleTerm<CR>", desc = "Term Toggle root" },
    {
      "<leader>wt",
      function()
        local is_open = #require("toggleterm.terminal").get_all(true) > 0
        if is_open then
          -- lifehack to focus on  toggleterm in focus from any state
          vim.api.nvim_command("TermExec cmd='' go_back=0")
          vim.schedule(function()
            -- always go to normal mode before insert mode for safety
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>i", true, false, true), "n", false)
          end)
        else
          vim.api.nvim_command("ToggleTerm dir=%:p:h")
        end
      end,
      desc = "ToggleTerm Focus",
    },
    {
      "<leader>qt",
      function()
        -- 3 <C-l> just in case if I have more than 1 vsplit open
        -- i is either insert mode or alias the first letter of alias "iexit" that is exit
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-l><C-l><C-l>i", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "m", false)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("exit<CR>", true, false, true), "m", false)
      end,
      desc = "Quit Toggle Term",
    },
  },
}
