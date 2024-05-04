return {
  "ray-x/go.nvim",
  ft = { "go", "gomod" },
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
  },
  config = function()
    require("go").setup()
  end,
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
