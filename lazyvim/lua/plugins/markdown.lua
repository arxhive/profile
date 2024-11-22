return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = false, -- must not be lazy to support copilot-chat
  opts = {
    file_types = { "markdown", "norg", "rmd", "org", "copilot-chat" },
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
