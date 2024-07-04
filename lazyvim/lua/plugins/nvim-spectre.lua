return {
  "nvim-pack/nvim-spectre",
  opts = {
    use_trouble_qf = true,
    is_insert_mode = true,
    mapping = {
      ["send_to_qf"] = {
        map = "<leader>Q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all items to quickfix",
      },
    },
  },
  keys = {
    {
      "<leader>sr",
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      mode = { "v" },
      desc = "Replace in Files (Spectre)",
    },
  },
}
