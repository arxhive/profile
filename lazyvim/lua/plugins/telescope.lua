return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = {
          "truncate", -- truncate | smart | shorten
        },
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "public/docs",
          "go/pkg",
        },
        layout_config = {
          horizontal = { width = 0.95 },
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- grep the current folder
      -- { "<C-f>", function() require('telescope.builtin').live_grep({ cwd = vim.fn.expand("%:h"), prompt_title="Grep current " .. vim.fn.expand("%:h")}) end, desc = "Grep (current)" },
      -- grep cwd
      { "<leader>ff", function()
        require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), prompt_title = "Grep cwd " .. vim.fn.getcwd() })
      end, desc = "Grep (cwd)" },
      { "<leader>fit", function()
        require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), glob_pattern="!*test*", prompt_title = "Grep cwd no test " .. vim.fn.getcwd() })
      end, desc = "Ignore tests" },

      -- grep root
      { "<leader>fF", LazyVim.telescope("live_grep", { prompt_title = "Grep root " .. LazyVim.root()}), desc = "Grep (root)" },
      { "<leader>fs", function() vim.cmd("Telescope grep_string") end, mode = {"n", "x" }, desc = "Grep current or selection (cwd)" },
      -- files
      { "<leader><space>", function()
        require('telescope.builtin').fd({ cwd = vim.fn.getcwd(), prompt_title = "Files cwd " .. vim.fn.getcwd() })
      end, desc = "Find Files (cwd)" },
      { "<S-space>", function()
        require('telescope.builtin').fd({ cwd = LazyVim.root(), prompt_title = "Files root " .. LazyVim.root() })
      end, desc = "Find Files (Root Dir)" },
      { "<leader>gh", function() vim.cmd("Telescope git_bcommits") end, mode = {"n" }, desc = "Git File History" },
      { "<C-p>", function() require("telescope").extensions.yank_history.yank_history() end, mode = { "n", "x" }, desc = "Telescope yank history" },
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
  {
    "jemag/telescope-diff.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    keys = {
    -- stylua: ignore start
      -- { "<leader>sC", function() require("telescope").extensions.diff.diff_files({ hidden = true }) end, desc = "Compare 2 files" },
      { "<leader>sc", function() require("telescope").extensions.diff.diff_current({ hidden = true }) end, desc = "Compare with current" },

      -- stylua: ignore end
    },
  },
}
