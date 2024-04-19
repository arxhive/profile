return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
      require("telescope").load_extension("rest") -- :Telescope rest select_env
    end,
    -- stalua: ignore
    keys = {
      { "<leader>hr", "<cmd>Rest run<cr>", "Run request under the cursor" },
      { "<leader>hl", "<cmd>Rest run last<cr>", "Re-run latest request" },
    },
  },
}
