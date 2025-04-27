local my_telescope_layout = {
  preset = "telescope",
  layout = {
    box = "horizontal",
    backdrop = false,
    width = 0.95,
    height = 0.95,
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
          filename_only = true, -- only show the filename
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
      sources = {
        explorer = {
          title = "",
          enabled = true,
          layout = { preset = "sidebar", preview = false },
          diagnostics = false,
          git_status = true,
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
        files = {
          layout = my_telescope_layout,
        },
      },
    },
  },
}
