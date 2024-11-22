return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function()
      require("CopilotChat").setup({
        highlight_headers = false,
        separator = "",
        auto_insert_mode = true,
        insert_at_end = true,
        clear_chat_on_new_prompt = false,
        highlight_selection = false,
      })
    end,
    keys = function()
      local copilot_chat = require("CopilotChat")
      local telescope = require("CopilotChat.integrations.telescope")
      local actions = require("CopilotChat.actions")

      return {
        {
          "<leader>ac",
          copilot_chat.toggle,
          desc = "CopilotChat",
          mode = { "n", "v" },
        },
        {
          "<leader>ax",
          copilot_chat.reset,
          desc = "Clear CopilotChat",
          mode = { "n", "v" },
        },
        {
          "<leader>aq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              copilot_chat.ask(input)
            end
          end,
          desc = "Quick Chat",
          mode = { "n", "v" },
        },
        {
          "<C-\\>",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              copilot_chat.ask(input)
            end
          end,
          desc = "Quick Chat (CopilotChat)",
          mode = { "n", "v" },
        },
        {
          "|",
          function()
            telescope.pick(actions.prompt_actions())
          end,
          desc = "Prompt Actions",
          mode = { "n", "v" },
        },
        {
          "<leader>ad",
          function()
            local help = actions.help_actions()
            if not help then
              LazyVim.warn("No diagnostics found on the current line")
              return
            end
            telescope.pick(help)
          end,
          desc = "Diagnostic Help",
          mode = { "n", "v" },
        },
        {
          "<leader>ap",
          function()
            telescope.pick(actions.prompt_actions())
          end,
          desc = "Prompt Actions",
          mode = { "n", "v" },
        },
        {
          "<leader>am",
          copilot_chat.select_model,
          desc = "Select Model",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
