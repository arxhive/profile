return {
  {
    "stevearc/aerial.nvim",
    event = function(_, event)
      return {}
    end,
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
      layout = {
        max_width = { 80, 0.4 },
        width = nil,
        min_width = 50,
      },
      float = {
        border = "",
      },
    },
  -- stylua: ignore
    keys = {
        { "<C-S-S>", function() require("aerial").toggle() end, desc = "Toggle Aerial" },
        { "<C-S-A>", function() require("aerial").open({ direction = "float" }) end, desc = "Float Aerial" },
     },
  },
}
