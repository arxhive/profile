return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
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
    follow_current_file = {
      enable = true,
      show_root = true,
    },
  },
  keys = {
    { "<C-S-Q>", function()
        require("neo-tree.command").execute({ toggle = true, source="filesystem", dir = LazyVim.root() })
      end,
      desc = "NeoTree (Root Dir)", remap = true
    },
    { "<C-S-B>", function()
        require("neo-tree.command").execute({ toggle = true, source="buffers", position="left" })
      end,
      desc = "NeoTree buffers", remap = true
    },
    { "<C-S-G>", function()
        require("neo-tree.command").execute({ toggle = true, source="git_status" })
      end,
      desc = "NeoTree git status", remap = true
    },
  },
}
