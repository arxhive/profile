return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    opts = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "public/docs",
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<C-S-p>", function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, { desc = "Telescope yank history" } },
      { "<leader>snt", function() vim.cmd("Noice telescope") end, { desc = "Noice telescope" } },
      { "<C-f>", function() vim.cmd("Telescope live_grep") end, { desc = "Grep" } },
      { "<C-S-f>", function() vim.cmd("Telescope grep_string") end, { desc = "Grep string" } },
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    module = "telescope._extensions.luasnip", -- used for lazy loading
    keys = {
      -- stylua: ignore
      { "<leader>sl", function() require("telescope").extensions.luasnip.luasnip() end, { noremap = true, silent = true, desc = "luasnip" } }, -- fix whichkey
    },
  },
}
