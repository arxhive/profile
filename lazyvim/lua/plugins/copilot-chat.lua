return {
  "CopilotC-Nvim/CopilotChat.nvim",
  keys = function()
    return {
      {
        "<leader>ac",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "CopilotChat",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear CopilotChat",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
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
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "|",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      {
        "<leader>ad",
        function()
          local actions = require("CopilotChat.actions")
          local help = actions.help_actions()
          if not help then
            LazyVim.warn("No diagnostics found on the current line")
            return
          end
          require("CopilotChat.integrations.telescope").pick(help)
        end,
        desc = "Diagnostic Help",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      {
        "<leader>ap",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Prompt Actions",
        mode = { "n", "v" },
      },
    }
  end,
}
