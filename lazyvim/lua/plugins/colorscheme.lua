return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      -- flavour = "latte",
      -- flavour = "macchiato",
      flavour = "mocha",
      no_italic = true,
      highlight_overrides = {
        all = function(colors)
          local ucolors = require("catppuccin.utils.colors")
          local telescope_results = ucolors.darken(colors.mantle, 1.15, "#000000")
          local telescope_prompt = ucolors.darken(telescope_results, 0.95, "#000000")
          local telescope_text = colors.text
          local telescope_prompt_title = colors.lavender
          local telescope_preview_title = colors.lavender

          return {
            -- NoiceCmdlinePopup = { bg = colors.mantle },
            NoiceMini = { bg = colors.mantle },
            TelescopeBorder = { bg = telescope_results, fg = telescope_results },
            TelescopePromptBorder = { bg = telescope_prompt, fg = telescope_prompt },
            TelescopePromptCounter = { fg = telescope_text },
            TelescopePromptNormal = { fg = telescope_text, bg = telescope_prompt },
            TelescopePromptPrefix = { fg = telescope_prompt_title, bg = telescope_prompt },
            TelescopePromptTitle = { fg = telescope_prompt, bg = telescope_prompt_title },
            TelescopePreviewTitle = { fg = telescope_results, bg = telescope_preview_title },
            TelescopePreviewBorder = {
              bg = ucolors.darken(telescope_results, 0.95, "#000000"),
              fg = ucolors.darken(telescope_results, 0.95, "#000000"),
            },
            TelescopePreviewNormal = {
              bg = ucolors.darken(telescope_results, 0.95, "#000000"),
              fg = telescope_results,
            },
            TelescopeResultsTitle = { fg = telescope_results, bg = telescope_preview_title },
            TelescopeMatching = { fg = telescope_prompt_title },
            TelescopeNormal = { bg = telescope_results },
            -- TelescopeSelection = { bg = telescope_prompt },
            -- TelescopeSelectionCaret = { fg = telescope_text },
            TelescopeResultsNormal = { bg = telescope_results },
            TelescopeResultsBorder = { bg = telescope_results, fg = telescope_results },
          }
        end,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "storm" },
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
