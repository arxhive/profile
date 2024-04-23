return {
  {
    "stevearc/aerial.nvim",
    opts = {
      lazy_load = true,
      highlight_on_hover = true,
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },
    },
  -- stylua: ignore
    keys = {
    { "<C-S-S>", function() require("aerial").toggle() end, { desc = "Toggle Aerial" }, },
    { "<C-S-A>", function() require("aerial").open({ direction = "float" }) end, { desc = "Float Aerial" }, },
  } ,
  },
}
