return {
  "lukas-reineke/headlines.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.markdown = {
      fat_headline_lower_string = "▔",
      -- bullets = {},
    }
    return opts
  end,
}
