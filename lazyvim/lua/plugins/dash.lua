-- stylua: ignore
return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    table.remove(opts.config.center, 1)
    table.insert(opts.config.center, 1, { action = LazyVim.pick("files"), desc = " Find File", icon = "󰍉 ", key = "f" })
  end,
}
