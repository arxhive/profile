return {
  {
    "nosduco/remote-sshfs.nvim",
    cmd = { "RemoteSSHFSConnect", "RemoteSSHFSEdit", "RemoteSSHFSReload" },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("remote-sshfs").setup({})
    end,
  },
}
