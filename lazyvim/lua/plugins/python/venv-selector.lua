return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    name = "venv",
    search_venv_managers = true,
    search = true,
    parents = 4,
    auto_refresh = true,
    pipenv_path = ".",
  },
  -- event = "VeryLazy",
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>cps", "<cmd>VenvSelect<cr>", desc = "Venv Select" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>cpc", "<cmd>VenvSelectCached<cr>", desc = "Venv Cached" },
  },
}
