return {
  "stevearc/oil.nvim",
  lazy = true,
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    keymaps = {
      ["<bs>"] = "actions.parent",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  keys = {
    { "<C-S-W>", function() require("oil").open() end, desc = "Oil open" },
  },
}
