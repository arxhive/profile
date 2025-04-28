return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = true,
  dependencies = {
    "miversen33/netman.nvim",
    "nvim-tree/nvim-web-devicons",
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
      opts.enable_git_status = false
      opts.enable_diagnostics = false

      require("neo-tree").setup(opts)
      -- vim.api.nvim_create_autocmd("TermClose", {
      --   pattern = "*lazygit",
      --   callback = function()
      --     if package.loaded["neo-tree.sources.git_status"] then
      --       require("neo-tree.sources.git_status").refresh()
      --     end
      --   end,
      -- })
    end,

    sources = { "filesystem", "buffers", "document_symbols", "git_status", "netman.ui.neo-tree" },

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
        ["S"] = "open_vsplit",
        ["<C-s>"] = "open_vsplit",
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
        ["<leader>fn"] = "grep_telescope",
        ["<leader>sn"] = "files_telescope",
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
    commands = {
      grep_telescope = function(state)
        local node = state.tree:get_node()
        local neopath = node:get_id()

        if string.find(neopath, "%.") then
          neopath = vim.fn.fnamemodify(neopath, ":h")
        end

        require("telescope.builtin").live_grep({ cwd = neopath, prompt_title = "Grep neotree " .. neopath })
      end,
      files_telescope = function(state)
        local node = state.tree:get_node()
        local neopath = node:get_id()

        if string.find(neopath, "%.") then
          neopath = vim.fn.fnamemodify(neopath, ":h")
        end

        require("telescope.builtin").fd({ cwd = neopath, prompt_title = "Files neotree " .. neopath })
      end,
    },
  },
  cmd = "Neotree",
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  keys = {
    { "<leader>fc", false },
    { "<leader>fe", false },
    { "<leader>fE", false },
    -- {
    --   "<leader>E",
    --   function()
    --     require("neo-tree.command").execute({ toggle = true, source = "filesystem", dir = Tricks.rootdir() })
    --   end,
    --   desc = "NeoTree (root)",
    -- },
    -- {
    --   "<leader>e",
    --   function()
    --     require("neo-tree.command").execute({ toggle = true, source = "filesystem", dir = vim.uv.cwd() })
    --   end,
    --   desc = "NeoTree (cwd)",
    -- },
    {
      "<leader>qe",
      function()
        vim.api.nvim_command("Neotree close")
        -- TODO: Check if it's trully opened
        Snacks.explorer.open()
      end,
      desc = "Quit NeoTree",
    },
    {
      "<leader>we",
      function()
        local command = "Neotree dir=" .. vim.uv.cwd() .. " reveal_file=%:p"

        local path = vim.fn.expand("%:p")
        -- check is "neo-tree " exists in the path
        if string.find(path, "tree ") then
          -- switch neotree focus to the last opened file
          vim.api.nvim_command("bnext")
          vim.schedule(function()
            vim.api.nvim_command(command)
          end)
          -- if no buffer opened (for instance, we're in oil)
        elseif string.find(path, "/$") then
          -- just open a default explorer
          vim.api.nvim_command("Neotree filesystem focus")
        else
          -- open neotree and reveal the file
          vim.api.nvim_command(command)
        end
      end,
      desc = "NeoTree reveal file",
    },
    {
      "<leader>wf",
      function()
        require("neo-tree.command").execute({ source = "filesystem", reveal = true, reveal_force_cwd = true })
      end,
      desc = "NeoTree reveal force",
      remap = true,
    },
    -- use telescope instead
    -- {
    --   "<leader>wb",
    --   function()
    --     require("neo-tree.command").execute({ source = "buffers", position = "float" })
    --   end,
    --   desc = "NeoTree buffers",
    --   remap = true,
    -- },
    {
      "<leader>wr",
      function()
        require("neo-tree.command").execute({ source = "remote", position = "left" })
      end,
      desc = "NeoTree remote",
      remap = true,
    },
    {
      "<leader>wg",
      function()
        vim.cmd("DBUIToggle")
      end,
      desc = "Database Explorer",
    },
  },
}
