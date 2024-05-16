return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  dependencies = {
    "miversen33/netman.nvim",
  },
  init = function()
    -- uncomment to enable auto open on dir
    -- if vim.fn.argc(-1) == 1 then
    --   local stat = vim.uv.fs_stat(vim.fn.argv(0))
    --   if stat and stat.type == "directory" then
    --     require("neo-tree")
    --   end
    -- end
  end,
  opts = {
    config = function(_, opts)
      local function on_move(data)
        LazyVim.lsp.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
    sources = { "filesystem", "buffers", "git_status", "document_symbols", "netman.ui.neo-tree" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true,
        show_root = true,
      },
      filtered_items = {
        visible = true,
        hide_hidden = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_pattern = {
          "*-lock.json",
        },
        hide_by_name = {
          "node_modules",
          "dist",
        },
        never_show = {
          ".DS_Store",
          ".git",
          "LICENSE",
          "node_modules",
          "package-lock.json",
          "dist",
        },
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["s"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
      },
    },
    default_component_configs = {
      indent = {
        with_markers = false,
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  keys = {
    {
      "<C-S-Q>",
      function()
        require("neo-tree.command").execute({ toggle = true, source = "filesystem", dir = LazyVim.root() })
      end,
      desc = "NeoTree (Root Dir)",
      remap = true,
    },
    {
      "<C-S-B>",
      function()
        require("neo-tree.command").execute({ toggle = true, source = "buffers", position = "float" })
      end,
      desc = "NeoTree buffers",
      remap = true,
    },
    {
      "<C-S-R>",
      function()
        require("neo-tree.command").execute({ toggle = true, source = "remote", position = "left" })
      end,
      desc = "NeoTree remote",
      remap = true,
    },
    -- { "<C-S-G>", function()
    --     require("neo-tree.command").execute({ toggle = true, source="git_status" })
    --   end,
    --   desc = "NeoTree git status", remap = true
    -- },
  },
}
