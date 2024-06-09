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
          -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
          -- https://github.com/catppuccin/catppuccin/blob/main/docs/translation-table.md

          local ucolors = require("catppuccin.utils.colors")
          local popup_bg = ucolors.darken(colors.mantle, 1.05, "#000000") -- ligher
          local prompt_bg = ucolors.darken(popup_bg, 0.95, "#000000") -- darker
          local telescope_text = colors.text
          -- local prompt_title_bg = "#F5BDE6" -- Pink light
          local prompt_title_bg = "#C6A0F6" -- Mauve light
          -- local prompt_title_bg = colors.lavender

          -- ucolors.

          return {
            NoiceCmdlinePopup = { bg = popup_bg },
            NoiceCmdlinePopupTitle = { fg = prompt_bg, bg = prompt_title_bg },

            -- NoiceMini = { bg = colors.mantle },

            TelescopeBorder = { bg = popup_bg, fg = popup_bg },
            TelescopePromptBorder = { bg = prompt_bg, fg = prompt_bg },
            TelescopePromptCounter = { fg = telescope_text },
            TelescopePromptNormal = { fg = telescope_text, bg = prompt_bg },
            TelescopePromptPrefix = { fg = prompt_title_bg, bg = prompt_bg },
            TelescopePromptTitle = { fg = prompt_bg, bg = prompt_title_bg },
            TelescopePreviewTitle = { fg = popup_bg, bg = prompt_title_bg },
            TelescopePreviewBorder = {
              bg = ucolors.darken(popup_bg, 0.95, "#000000"),
              fg = ucolors.darken(popup_bg, 0.95, "#000000"),
            },
            TelescopePreviewNormal = {
              bg = ucolors.darken(popup_bg, 0.95, "#000000"),
              -- fg = telescope_results,
            },
            TelescopeResultsTitle = { fg = popup_bg, bg = prompt_title_bg },
            TelescopeMatching = { fg = prompt_title_bg },
            TelescopeNormal = { bg = popup_bg },
            -- TelescopeSelection = { bg = telescope_prompt },
            -- TelescopeSelectionCaret = { fg = telescope_text },
            TelescopeResultsNormal = { bg = popup_bg },
            TelescopeResultsBorder = { bg = popup_bg, fg = popup_bg },
          }
        end,
      },
    },
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true,
  --   opts = { style = "storm" },
  -- },
  -- {
  --   "shaunsingh/nord.nvim",
  --   lazy = true,
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   lazy = false,
  --   priority = 1000,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
