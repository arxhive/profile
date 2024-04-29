return {
  "sindrets/diffview.nvim",
  keys = {
    {
      "<C-S-G>",
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
      "<C-S-H>",
      function()
        if next(require("diffview.lib").views) == nil then
          require("diffview").file_history()
        else
          require("diffview").close()
        end
      end,
      desc = "Diffview Toggle",
      remap = true,
    },
  },
}
