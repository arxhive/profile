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
          "go/pkg",
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<C-S-p>", function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, { desc = "Telescope yank history" } },
      { "<leader>snt", function() vim.cmd("Noice telescope") end, { desc = "Noice telescope" } },
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
