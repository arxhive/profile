local my_telescope_layout = {
  preset = "telescope",
  layout = {
    box = "horizontal",
    backdrop = false,
    width = 0.95,
    height = 0.95,
  },
}

local git_actions = {
  inspect_commit = function(picker, item)
    vim.notify(vim.inspect(item))
    picker:close()
  end,
  copy_sha = function(picker, item)
    vim.notify("Copied " .. item.commit .. " to clipboard")
    vim.fn.setreg("+", item.commit)
    picker:close()
  end,
}

local git_input = {
  input = {
    keys = {
      ["<C-y>"] = { "copy_sha", mode = { "i", "n" } },
    },
  },
}

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    dashboard = { enabled = false },
    notifier = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false }, -- use vim-illuminate instead
    profiler = { enabled = false },
    scroll = { enabled = false },
    indent = { enabled = false },
    input = {
      enabled = true,
    },
    picker = {
      enabled = true,
      ui_select = true,
      formatters = {
        file = {
          filename_first = false, -- display filename before the file path
          truncate = 40, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
          icon_width = 2, -- width of the icon (in characters)
          git_status_hl = false, -- use the git status highlight group for the filename
        },
      },
      win = {
        -- input window
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#-sources
      sources = {
        explorer = {
          title = "",
          enabled = true,
          layout = { preset = "sidebar", preview = false },
          diagnostics = false,
          git_status = true,
          hidden = true,
          -- disable indent lines
          icons = {
            tree = {
              vertical = "  ",
              middle = "  ",
              last = "  ",
            },
          },
        },
        files = {
          layout = my_telescope_layout,
          hidden = true,
        },
        grep = {
          layout = my_telescope_layout,
          hidden = true,
          args = { "--fixed-strings" },
        },
        grep_word = {
          layout = my_telescope_layout,
          hidden = true,
          args = { "--fixed-strings" },
        },
        lsp_definitions = {
          layout = my_telescope_layout,
        },
        lsp_type_definitions = {
          layout = my_telescope_layout,
        },
        lsp_declarations = {
          layout = my_telescope_layout,
        },
        lsp_implementations = {
          layout = my_telescope_layout,
        },
        lsp_references = {
          layout = my_telescope_layout,
        },
        lsp_symbols = {
          layout = my_telescope_layout,
        },
        git_log = {
          layout = my_telescope_layout,
          actions = git_actions,
          win = git_input,
        },
        git_log_file = {
          layout = my_telescope_layout,
          actions = git_actions,
          win = git_input,
        },
        git_log_line = {
          layout = my_telescope_layout,
          actions = git_actions,
          win = git_input,
        },
        git_status = {
          layout = my_telescope_layout,
        },
        buffers = {
          layout = my_telescope_layout,
        },
        resume = {
          layout = my_telescope_layout,
        },
        recent = {
          layout = my_telescope_layout,
        },
        lsp_workspace_symbols = {
          layout = my_telescope_layout,
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start

    -- explorer
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer cwd" },
    { "<leader>E", function() Snacks.explorer({ cwd = Tricks.rootdir() }) end, desc = "File Explorer root" },

    -- git tools
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

    -- grep cwd
    { "<leader>ff", function() Snacks.picker.grep({ title = "Grep cwd: " .. Tricks.cwd() }) end, desc = "Grep cwd" },
    { "<leader>fw", function() Snacks.picker.grep_word({ title = "Grep Word cwd: " .. Tricks.cwd() }) end, mode = { "n", "x" }, desc = "Grep word or selection cwd" },

    -- grep root
    { "<leader>fF", function() Snacks.picker.grep({ cwd = Tricks.rootdir(), title = "Grep root: " .. Tricks.rootdir_name() }) end, desc = "Grep root" },
    { "<leader>fW", function() Snacks.picker.grep_word({ cwd = Tricks.rootdir(), title = "Grep Word root: " .. Tricks.rootdir_name()}) end, mode = {"n", "x" }, desc = "Grep word or selection root" },

    -- files
    { "<leader><space>", function() Snacks.picker.files({ title = "Files cwd: " .. Tricks.cwd() }) end, desc = "Files cwd" },
    { "<M-space>", function() Snacks.picker.files({ cwd = Tricks.rootdir(), title = "Files root: " .. Tricks.rootdir_name() }) end, desc = "Files root", mode = { "n", "x" } }, -- Handles 0x1b 0x20 hex codes on S-Space from iterm2

    -- buffers
    { "<leader>wb", function() Snacks.picker.buffers() end, mode = {"n" }, desc = "Buffers" },

    -- resume search
    { "<leader>se", function() Snacks.picker.resume() end, desc = "Resume search" },
    -- { "<leader>fr", function() Snacks.picker.recent({ cwd = vim.uv.cwd() }) end, desc = "Recent files" },

    -- symbols
    { "<leader>sw", function() Snacks.picker.lsp_workspace_symbols({ filter = LazyVim.config.kind_filter }) end, desc = "Workspace Symbols Snacks"},

    -- Snacks picker sources
    { "<leader>wp", function() Snacks.picker.projects() end,  desc = "Projects" },
    { "<leader>wu", function() Snacks.picker.undo() end, desc = "Undo log" },

    -- advanced filters
    { "<leader>fit",
      function()
        Snacks.picker.grep({ cwd = vim.fn.getcwd(), exclude={ "coverage", "dist", "*test*", "*fixture*", "*.spec.*", "e2e", "it" }, title = "Grep cwd no tests: " .. Tricks.cwd() })
      end,
      desc = "Ignore tests cwd"
    },

    { "<leader>fiT",
      function()
        Snacks.picker.grep({ cwd = Tricks.rootdir(), exclude={ "coverage", "dist", "*test*", "*fixture*", "*.spec.*", "e2e", "it" }, title = "Grep root no tests: " .. Tricks.rootdir_name() })
      end,
      desc = "Ignore tests root"
    },

    { "<leader>fip",
      function()
        Snacks.picker.grep({ cwd = vim.fn.getcwd(), exclude={ "coverage", "dist", "package.json", "package-lock.json", "packages.lock.json", "packages.config", "go.mod", "go.sum", "*.gradle", "*.pom", "requirements.txt" }, title = "Grep cwd no packages: " .. Tricks.cwd() })
      end,
      desc = "Ignore packages cwd"
    },

    { "<leader>fiP",
      function()
        Snacks.picker.grep({ cwd = Tricks.rootdir(), exclude={ "coverage", "dist", "package.json", "package-lock.json", "packages.lock.json", "packages.config", "go.mod", "go.sum", "*.gradle", "*.pom", "requirements.txt" }, title = "Grep root no packages: " .. Tricks.rootdi_namer() })
      end,
      desc = "Ignore packages root"
    },

    -- disabled
    { "<leader>fe", false },
    { "<leader>fE", false },

    -- stylua: ignore end
  },
}
