return {
  {
    "4O4/lua-reactivex",
    build = function(plugin)
      vim.uv.fs_symlink(plugin.dir, plugin.dir .. "/lua", { dir = true })
    end,
  },
  {
    "dgrbrady/nvim-docker",
  },
}
