-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("telescope").load_extension("luasnip")
require("netman")
require("s3edit").setup()
require("remote-sshfs").setup({})
require("telescope").load_extension("remote-sshfs")
