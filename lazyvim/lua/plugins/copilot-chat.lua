local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  ExplainProject = [[I am a software engineer and I opened this project at the first time.
  Please onboard me into this project.
  Provide web request flow understanding, including entrypoints and all posible scenarios.
  Provide expected errors and error messages.
  Highlight asynchronious calls if any.
  And visualize a component digramm using UML format]],
  Review = "Please review the following code and provide suggestions for improvement.",
  ReviewPR = "You're a senior engineer in the big enterprise company. Please review my change request based on the current git diff. Make sure to check the code quality, current programming language stanrdards, and best practices. Provide suggestions for improvements and bettern naming for types, variables, and functions. If you find any bugs or potential issues, please point them out.",
  PRDescription = "Please generate a commit message for code changes based on git diff and git log of the current working branch. Be consise and clear, use buller points to summarize my changes. Add a task number id if my branch contains one.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  BetterVarName = "Please rename the variable correctly in given selection based on context",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  UML = "I want to present my changes to the team before code review. Please analyze my git diff changes and present a simply UML digramm for review purposes.",
  ConsiseCommit = "> #git:staged\nWrite commit message for the change with commitizen convention. Be consise. Keep the message in a single line under 72 characters. Avoid decomposition into title and message.",
  Debug = "This function doesn't work as expected. Please debug the following code and provide a solution.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function()
      require("CopilotChat").setup({
        model = "claude-3.7-sonnet",
        -- model = "gpt-4o",
        question_header = "#### in",
        answer_header = "## out",
        chat_autocomplete = true,
        highlight_headers = false,
        separator = "",
        auto_insert_mode = true,
        insert_at_end = true,
        clear_chat_on_new_prompt = false,
        highlight_selection = false,
        prompts = prompts,
        context = { "buffer", "git:staged", "git:unstaged" },
        mappings = {
          complete = {
            insert = "<C-CR>",
            normal = "<C-CR>",
          },
          show_diff = {
            full_diff = true,
          },
        },
      })
    end,
    keys = function()
      local copilot_chat = require("CopilotChat")
      local telescope = require("CopilotChat.integrations.telescope")
      local actions = require("CopilotChat.actions")
      return {
        {
          "<leader>ac",
          copilot_chat.open,
          desc = "CopilotChat",
          mode = { "n", "v" },
        },
        {
          "<leader>qc",
          copilot_chat.close,
          desc = "Quit CopilotChat",
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
            -- require("CopilotChat").select_prompt({})
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
        {
          "<leader>as",
          copilot_chat.stop,
          desc = "CopilotChat Stop",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
