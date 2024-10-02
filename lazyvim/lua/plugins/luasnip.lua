return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "~/profile/lazyvim/lua/snippets" }, -- nvim-scissors
    })
  end,
  -- disable default <tab> and <s-tab> behavior in LuaSnip to override it by nvim-cmp
  keys = function()
    return {}
  end,
}
