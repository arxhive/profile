return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = function()
    -- clean up a default BufReadPost/InsertEnter events to use Kindle mode instead
    return {}
  end,
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-CR>",
        accept_word = "<C-;>",
        accept_line = "<C-'>",
        next = "<C-]>",
        prev = "<C-[>",
        dismiss = "<C-BS>",
      },
    },
    panel = {
      enabled = true,
      layout = {
        position = "right", -- | top | left | right
        ratio = 0.3,
      },
      keymap = {
        jump_prev = "<C-[>",
        jump_next = "<C-]>",
        accept = "<CR>",
        refresh = "gr",
        open = "<C-S-CR>",
      },
    },
    filetypes = {
      markdown = true,
      yaml = true,
      help = true,
    },
  },
  keys = {
    {
      "<leader>uo",
      function()
        local is_disabled = require("copilot.client").is_disabled()
        if is_disabled then
          require("copilot.command").enable()
          print("Copilot enabled")
        else
          require("copilot.command").disable()
          print("Copilot disabled")
        end
      end,
      desc = "Toggle Copilot",
    },
  },
}
