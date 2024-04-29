return {
  {
    "nosduco/remote-sshfs.nvim",
    lazy = true,
    event = "CmdlineEnter",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("remote-sshfs").setup({})
    end,
  },
}
