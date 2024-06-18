return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  opts = function(_, opts)
    local actions = require("diffview.actions")

    opts.view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    }
    opts.file_panel = {
      listing_style = "list", -- One of 'list' or 'tree'
    }
    opts.keymaps = {
      view = {
        { "n", "}", actions.select_next_entry, { desc = "Open the diff for the next file" } },
        { "n", "{", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
        { "n", "<S-Up>", actions.prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
        { "n", "<S-Down>", actions.next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },
      },
      diff3 = {
        { { "n", "x" }, "<S-Left>", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS version of the file" } },
        { { "n", "x" }, "<S-Right>", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
      },
    }
  end,
  keys = {
    {
      "<leader>gd",
      function()
        if next(require("diffview.lib").views) == nil then
          require("diffview").open()
        else
          require("diffview").close()
        end
      end,
      desc = "Diffview Toggle",
      remap = true,
    },
    {
      "<leader>gp",
      function()
        if next(require("diffview.lib").views) == nil then
          require("diffview").file_history()
        else
          require("diffview").close()
        end
      end,
      desc = "Project History (diffview)",
      -- remap = true,
    },
  },
}
