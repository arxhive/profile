-- stylua: ignore
return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    table.remove(opts.config.center, 1)
    table.insert(opts.config.center, 1, {
      action = function() require('telescope.builtin').fd({ cwd = vim.fn.getcwd(), prompt_title = "Files cwd " .. vim.fn.getcwd() }) end,
      desc = " Find File", icon = "󰍉 ", key = "f" })
  end,
}
