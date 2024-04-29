return {
  "mbbill/undotree",
  event = "BufRead",
  keys = {
    { "<C-S-U>", vim.cmd.UndotreeToggle, { desc = "Undo Tree" } },
  },
}
