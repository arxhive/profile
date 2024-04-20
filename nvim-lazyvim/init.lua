-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("telescope").load_extension("luasnip")
require("refactoring").setup()
require("netman")
require("neo-tree").setup({
  sources = {
    "filesystem",
    "netman.ui.neo-tree",
  },
})
