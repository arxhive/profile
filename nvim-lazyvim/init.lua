-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require('refactoring').setup()
require("cmp").setup {
	sources = {
		{ name = "cmp_yanky" },
	},
}
