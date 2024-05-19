return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "public/docs",
          "go/pkg",
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<C-S-p>", function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, desc = "Telescope yank history" },
      -- grep the current folder
      -- { "<C-f>", function() require('telescope.builtin').live_grep({ cwd = vim.fn.expand("%:h"), prompt_title="Grep current " .. vim.fn.expand("%:h")}) end, desc = "Grep (current)" },
      -- grep cwd
      { "<C-f>", function() require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), prompt_title="Grep cwd " .. vim.fn.getcwd() }) end, desc = "Grep (cwd)" },

      -- grep root
      { "<C-S-f>", LazyVim.telescope("live_grep", { prompt_title = "Grep root " .. LazyVim.root()}), desc = "Grep (root)" },
      { "<C-s>", function() vim.cmd("Telescope grep_string") end, mode = {"n", "x" }, desc = "Grep current or selection (cwd)" },
      { "<leader>snt", function() vim.cmd("Noice telescope") end, desc = "Noice telescope" },
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    keys = {
      -- stylua: ignore
      { "<leader>sl", function() require("telescope").extensions.luasnip.luasnip() end, desc = "Luasnip" }, -- fix whichkey
    },
  },
}
