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
      { "<leader>snt", function() vim.cmd("Noice telescope") end, desc = "Noice telescope" },
      { "<C-S-f>", LazyVim.telescope("live_grep", { prompt_title = "Grep root " .. LazyVim.root()}), desc = "Grep (root)" },
      { "<C-f>", LazyVim.telescope("live_grep", { cwd = vim.fn.expand("%:h:p"), prompt_title="Grep cwd"}), desc = "Grep (cwd)" },
      { "<C-s>", function() vim.cmd("Telescope grep_string") end, mode = {"n", "x" }, desc = "Grep current or selection (cwd)" }
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
