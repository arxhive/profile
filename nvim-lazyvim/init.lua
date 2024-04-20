-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("telescope").load_extension("luasnip")
require("refactoring").setup()
require("netman")
require("s3edit").setup()
require("neo-tree").setup({
  sources = {
    "filesystem",
    "netman.ui.neo-tree",
  },
})
require("remote-sshfs").setup({})
require("telescope").load_extension("remote-sshfs")
