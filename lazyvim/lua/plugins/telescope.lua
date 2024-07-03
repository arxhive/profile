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
      { "<leader>fF", function()
        require('telescope.builtin').live_grep({ cwd = Tricks.rootdir(),  prompt_title = "Grep root " .. Tricks.rootdir() })
      end, desc = "Grep (root)" },

      { "<leader>fs", function() vim.cmd("Telescope grep_string") end, mode = {"n", "x" }, desc = "Grep current or selection (cwd)" },

      -- files
      { "<leader><space>", function()
        require('telescope.builtin').fd({ cwd = vim.fn.getcwd(), prompt_title = "Files cwd " .. vim.fn.getcwd() })
      end, desc = "Find Files (cwd)" },
      { "<S-space>", function()
        require('telescope.builtin').fd({ cwd = Tricks.rootdir(), prompt_title = "Files root " .. Tricks.rootdir() })
      end, desc = "Find Files (Root Dir)" },

      { "<leader>gt", function() vim.cmd("Telescope git_bcommits") end, mode = {"n" }, desc = "File History (telescope)" },
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
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          file_browser = {
            depth = 1,
            hidden = { file_browser = false, folder_browser = false },
            display_stat = { date = false, size = false, mode = false },
            git_status = false,
            collapse_dirs = true,
            mappings = {
              ["i"] = {
                ["<C-n>"] = require("telescope._extensions.file_browser.actions").create,

                ["<S-CR>"] = require("telescope._extensions.file_browser.actions").create_from_prompt,
                ["<C-r>"] = require("telescope._extensions.file_browser.actions").rename,
                -- ["<C-o>"] = require("telescope._extensions.file_browser.actions").move,
                ["<C-y>"] = require("telescope._extensions.file_browser.actions").copy,
                ["<C-d>"] = require("telescope._extensions.file_browser.actions").remove,

                ["<C-o>"] = require("telescope._extensions.file_browser.actions").open,
                ["<C-g>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
                ["<C-e>"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
                ["<C-w>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
                ["<C-t>"] = require("telescope._extensions.file_browser.actions").change_cwd,
                ["<C-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
                ["<C-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
                ["<C-s>"] = require("telescope._extensions.file_browser.actions").toggle_all,
                ["<bs>"] = require("telescope._extensions.file_browser.actions").backspace,
              },
            },
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>wW",
        function()
          require("telescope").extensions.file_browser.file_browser({ path = Tricks.rootdir(), select_buffer = true, prompt_title = "Browse root " .. Tricks.rootdir() })
        end,
        desc = "File Browser (root)",
      },
      {
        "<leader>ww",
        function()
          require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true, prompt_title = "Browse cwd " .. vim.fn.getcwd() })
        end,
        desc = "File Browser (buf)",
      },
    },
  },
  {
    "natecraddock/workspaces.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("workspaces").setup({
        hooks = {
          -- open = { "Oil " .. vim.fn.getcwd() },
          -- open = { "Neotree" },
        },
      })
      require("telescope").load_extension("workspaces")
    end,
    keys = {
      {
        "<leader>wa",
        function()
          local tricks = require("config.tricks")
          local path = tricks.refined("%:h")
          vim.api.nvim_command("cd " .. path)
          vim.api.nvim_command("WorkspacesAdd")
          LazyVim.notify("cwd: " .. vim.uv.cwd())
        end,
        desc = "Workspace Add",
      },
      { "<leader>wt", ":Telescope workspaces<CR>", desc = "Workspaces" },
      { "<leader>wSa", ":WorkspacesAddDir<CR>", desc = "Workspace Add Dir" },
      { "<leader>wSs", ":WorkspacesSyncDirs<CR>", desc = "Workspaces Sync" },
      { "<leader>wSr", ":WorkspacesRemove<CR>", desc = "Remove workspace" },
      { "<leader>wSR", ":WorkspacesRemoveDir<CR>", desc = "Remove Dir" },
    },
  },
}
