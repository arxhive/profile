return {
  "stevearc/oil.nvim",
  lazy = true,
  opts = {
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    keymaps = {
      ["<bs>"] = "actions.parent",
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
