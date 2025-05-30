return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--no-ignore-vcs",
        },
        path_display = {
          "truncate", -- truncate | smart | shorten
        },
        file_ignore_patterns = {
          "node_modules",
          "venv",
          "public/docs",
          "go/pkg",
          "target/",
        },
        layout_config = {
          horizontal = { width = 0.95, height = 0.95 },
        },
        mappings = {
          i = {
            -- ["<C-a>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            ["<C-a>"] = require("telescope.actions").send_to_qflist,
            -- ["<C-s>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["<C-l>"] = require("telescope.actions").send_selected_to_qflist,
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- grep the current folder
      -- { "<C-f>", function() require('telescope.builtin').live_grep({ cwd = vim.fn.expand("%:h"), prompt_title="Grep current " .. vim.fn.expand("%:h")}) end, desc = "Grep (current)" },
      -- grep cwd
      -- Snacks version (it's faster)
      { "<leader>ff", function() Snacks.picker.grep({title = "Grep cwd " .. vim.fn.getcwd()}) end, desc = "Grep cwd" },
      -- Telescope version
      -- { "<leader>ff", function()
      --   require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), additional_args = {"--fixed-strings"}, glob_pattern="!{coverage/*,dist/*}", prompt_title = "Grep cwd " .. vim.fn.getcwd() })
      -- end, desc = "Grep (cwd)" },
      { "<leader>fit", function()
        require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), additional_args = {"--fixed-strings"}, glob_pattern="!{coverage/*,dist/*,*test*,*fixture*,*.spec.*,e2e}", prompt_title = "Grep cwd no test " .. vim.fn.getcwd() })
      end, desc = "Ignore tests" },
      { "<leader>fip", function()
        require('telescope.builtin').live_grep({ cwd = vim.fn.getcwd(), additional_args = {"--fixed-strings"}, glob_pattern="!{coverage/*,dist/*,package.json,package-lock.json,go.mod,go.sum}", prompt_title = "Grep cwd no packages " .. vim.fn.getcwd() })
      end, desc = "Ignore packages" },

      -- grep root
      { "<leader>fF", function()
        require('telescope.builtin').live_grep({ cwd = Tricks.rootdir(), additional_args = {"--fixed-strings"},  prompt_title = "Grep root " .. Tricks.rootdir() })
      end, desc = "Grep (root)" },

      { "<leader>fw", function() vim.cmd("Telescope grep_string") end, mode = {"n", "x" }, desc = "Grep word or selection (cwd)" },

      -- files
      -- { "<leader><space>", function()
      --   require('telescope.builtin').fd({ cwd = vim.fn.getcwd(), prompt_title = "Files cwd " .. vim.fn.getcwd() })
      -- end, desc = "Find Files (cwd)" },

      -- Snacks picker version
      { "<leader><space>", function() Snacks.picker.files({title = "Files cwd " .. vim.fn.getcwd()}) end, desc = "Files cwd" },
      { "<leader><CR>", function() Snacks.picker.files({ cwd = Tricks.rootdir(), title = "Files root " .. Tricks.rootdir() }) end, desc = "Files root" },

     -- { "<leader><CR>", function()
      --   require('telescope.builtin').find_files({ cwd = Tricks.rootdir(), prompt_title = "Files root " .. Tricks.rootdir() })
      -- end, desc = "Find Files (Root Dir)" },

      { "<leader>gf", function() vim.cmd("Telescope git_bcommits") end, mode = {"n" }, desc = "File History (telescope)" },
      { "<leader>wb", function() vim.cmd("Telescope buffers") end, mode = {"n" }, desc = "Buffers" },
      { "PP", function()
        vim.api.nvim_command("stopinsert")
        vim.schedule(function()
            require("telescope").extensions.yank_history.yank_history()
          end)
      end, mode = { "n", "x", "i" }, desc = "Telescope yank history" },
      { "<C-S-v>", function()
        vim.api.nvim_command("stopinsert")
        vim.schedule(function()
            require("telescope").extensions.yank_history.yank_history()
          end)
      end, mode = { "n", "x", "i" }, desc = "Telescope yank history" },

      -- resume search
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },

      -- show recent files
      { "<leader>sf", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent Files cwd" },
      -- { "<leader>sR", "<cmd>Telescope oldfiles<cr>", desc = "Recent files root" },

      -- disabled
      { "<leader>fR", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>fb", false },
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
                ["<C-v>"] = require("telescope._extensions.file_browser.actions").move,
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
          require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true, prompt_title = "Browse buf " .. vim.fn.expand("%:p:h") })
        end,
        desc = "File Browser (buf)",
      },
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
      -- remap to >fc when find a way how to override default mapping
      { "<leader>fC", function() require("telescope").extensions.diff.diff_current({ hidden = true }) end, desc = "Compare with current" },

      -- stylua: ignore end
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    keys = {
      -- stylua: ignore
      { "<leader>cc", function() require("telescope").extensions.luasnip.luasnip() end, desc = "Snippets" },
    },
    config = function()
      require("telescope").load_extension("luasnip")
    end,
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
      { "<leader>ws", ":Telescope workspaces<CR>", desc = "Workspaces" },
      { "<leader>wSa", ":WorkspacesAddDir<CR>", desc = "Workspace Add Dir" },
      { "<leader>wSs", ":WorkspacesSyncDirs<CR>", desc = "Workspaces Sync" },
      { "<leader>wSr", ":WorkspacesRemove<CR>", desc = "Remove workspace" },
      { "<leader>wSR", ":WorkspacesRemoveDir<CR>", desc = "Remove Dir" },
    },
  },
}
