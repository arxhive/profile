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
      color_overrides = {
        mocha = {
          sky = "#F5C2E7", -- Pink
          -- sky = "#F2CDCD", -- Flamingo
          -- sky = "#CBA6F7", -- Mauve
        },
      },
      highlight_overrides = {
        all = function(colors)
          -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
          -- https://github.com/catppuccin/catppuccin/blob/main/docs/translation-table.md

          local ucolors = require("catppuccin.utils.colors")
          local popup_bg = ucolors.darken(colors.mantle, 1.05, "#000000") -- ligher
          local prompt_bg = ucolors.darken(popup_bg, 0.95, "#000000") -- darker
          local telescope_text = colors.text
          local accent = colors.pink
          -- local accent = colors.mauve
          -- local accent = colors.lavender
          -- local prompt_title_bg = colors.lavender

          return {
            NormalFloat = { bg = popup_bg },
            FloatBorder = { bg = popup_bg, fg = popup_bg },
            FloatTitle = { fg = prompt_bg, bg = accent },

            TroubleNormal = { bg = popup_bg },
            NoiceCmdlinePopup = { bg = popup_bg },
            NoiceCmdlinePopupBorder = { bg = popup_bg, fg = popup_bg },
            NoiceCmdlinePopupTitleCmdline = { fg = prompt_bg, bg = accent },
            NoiceCmdlinePopupTitleSearch = { fg = prompt_bg, bg = accent },
            NoiceCmdlinePopupTitleLua = { fg = prompt_bg, bg = accent },
            NoiceCmdlinePopupTitleFilter = { fg = prompt_bg, bg = accent },
            NoiceCmdlinePopupTitleInput = { fg = prompt_bg, bg = accent },

            -- NoiceMini = { bg = colors.mantle },

            TelescopeBorder = { bg = popup_bg, fg = popup_bg },
            TelescopePromptBorder = { bg = prompt_bg, fg = prompt_bg },
            TelescopePromptCounter = { fg = telescope_text },
            TelescopePromptNormal = { fg = telescope_text, bg = prompt_bg },
            TelescopePromptPrefix = { fg = accent, bg = prompt_bg },
            TelescopePromptTitle = { fg = prompt_bg, bg = accent },
            TelescopePreviewTitle = { fg = popup_bg, bg = accent },
            TelescopePreviewBorder = {
              bg = ucolors.darken(popup_bg, 0.95, "#000000"),
              fg = ucolors.darken(popup_bg, 0.95, "#000000"),
            },
            TelescopePreviewNormal = {
              bg = ucolors.darken(popup_bg, 0.95, "#000000"),
              -- fg = telescope_results,
            },
            TelescopeResultsTitle = { fg = popup_bg, bg = accent },
            TelescopeMatching = { fg = accent },
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
