return {
  "MeanderingProgrammer/markdown.nvim",
  -- Here is an updated plugin reference, but lazyvim doesn't use it yet
  -- "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown", "norg", "rmd", "org" },
    render_modes = { "n", "c", "i" },
    code = {
      sign = false,
      width = "full",
      right_pad = 1,
    },
    heading = {
      enabled = true,
      sign = false,
      width = "block",
      icons = {},
    },
  },
}
