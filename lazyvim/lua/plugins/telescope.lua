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
            ["<C-Q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            -- ["<C-Q>"] = require("telescope.actions").send_to_qflist,
            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            -- ["<C-q>"] = require("telescope.actions").send_selected_to_qflist,
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      -- yank history
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

      -- show recent files
      -- ues telescope because Snacks.picker doesn't respect cwd for recent files
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent files" },
      -- { "<leader>sR", "<cmd>Telescope oldfiles<cr>", desc = "Recent files root" },

      -- symbols
      {
        "<leader>sa",
        "<cmd>Telescope aerial<cr>",
        desc = "Aerial Symbols",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = LazyVim.config.get_kind_filter(),
          })
        end,
        desc = "Workspace Symbols",
      },
      { "<leader>st", function() require("telescope.builtin").current_buffer_fuzzy_find { default_text = "TODO:" } end, desc = "Todo Buffer" },

      -- disabled
      { "<leader><space>", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fR", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>fb", false },
      { "<leader>sr", false },
      { "<leader>sR", false },
      { "<leader>sS", false },
      { "<leader>gs", false }, -- git status
      { "<leader>sm", false }, -- git status
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
                ["<C-x>"] = require("telescope._extensions.file_browser.actions").move, -- because <C-m> == <CR>
                ["<C-p>"] = require("telescope._extensions.file_browser.actions").copy, -- actually copy and paste selected entry
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
        desc = "File Browser root",
      },
      {
        "<leader>ww",
        function()
          require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", select_buffer = true, prompt_title = "Browse buf " .. vim.fn.expand("%:p:h") })
        end,
        desc = "File Browser buf",
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
      {
        "<leader>ws",
        function()
          vim.api.nvim_command("Telescope workspaces")
        end,
        desc = "Workspaces",
      },
      {
        "<leader>wSa",
        function()
          vim.api.nvim_command("WorkspacesAddDir")
        end,
        desc = "Workspace Add Dir",
      },
      {
        "<leader>wSs",
        function()
          vim.api.nvim_command("WorkspacesSyncDirs")
        end,
        desc = "Workspaces Sync",
      },
      {
        "<leader>wSr",
        function()
          vim.api.nvim_command("WorkspacesRemove")
        end,
        desc = "Remove workspace",
      },
      {
        "<leader>wSR",
        function()
          vim.api.nvim_command("WorkspacesRemoveDir")
        end,
        desc = "Remove Dir",
      },
    },
  },
}
