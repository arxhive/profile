local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Onboarding = [[I am a software engineer and I opened this project at the first time.
Please onboard me into this project.
Explain the project structure, main components, and how they interact with each other.
Describe clients request flow, including entrypoints, downstream dependencies and all posible scenarios.
Provide expected errors and error messages.
Highlight asynchronious calls to other service if any.
And visualize a component digramm using UML format]],
  Implement = "Implement the following function, think about it, test and review it, rewrite if there are potential errors :\n1.",
  Review = "Please review the following code and provide suggestions for improvement.",
  ReviewPR = "You're a senior engineer in the big enterprise company. Please review my change request based on the current git diff. Make sure to check the code quality, current programming language stanrdards, and best practices. Provide suggestions for improvements and bettern naming for types, variables, and functions. If you find any bugs or potential issues, please point them out.",
  PRDescription = [[> #git:staged
> #system:`git rev-parse --abbrev-ref HEAD`
Please generate a commit message for code changes based on git diff and git log of the current working branch. Be consise and clear, use buller points to summarize my changes. Add a task number id if my branch contains one.",
Tests = "Please explain how the selected code works, then generate unit tests for it.",
Refactor = "Please refactor the following code to improve its clarity and readability.",
FixCode = "Please fix the following code to make it work as intended.",
FixError = "Please explain the error in the following text and provide a solution.",
BetterNamings = "Please provide better names for the following variables and functions.",
BetterVarName = "Please rename the variable correctly in given selection based on context",
Documentation = "Please provide documentation for the following code.",
SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
UML = "I want to present my changes to the team before code review. Please analyze my git diff changes and present a simply UML digramm for review purposes.]],
  ConsiseCommit = [[> #git:staged
> #system:`git rev-parse --abbrev-ref HEAD`
Write commit message for the change with commitizen convention.
Be consise. Keep the message in a single line under 72 characters.
Take a task id from branch name if possible (it should be something like PROJECTNAME-1234. Attach task id at the end of commit message in squared brackets.
Avoid decomposition into title and message.]],
  ThinkingMode = "$claude-3.7-sonnet-thought\nLets work through this step by step, showing your reasoning in detail. Consider different approaches and explain the tradeoffs. Think about edge cases and potential issues.",
  Debug = "This function doesn't work as expected. Please debug the following code and provide a solution.",
  Context = "Show me all files in your current context.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
  TechDoc = [[You're a fractional CTO of the current service. Your goal is to write a clear, consise, technical savy strategy documentation for engineers.
I provide a draft of the document with high level bullet points I need to elaborate on.

I will use the following tags notation after the bullet points to guide you:
#consise - just a brief summary of this topic in one on two sentences.
#deepdive - make a research and provide a professional expertise on this topic. Avoid buzzwords and high level rambling. None likes water in the text. Image you write for engineers. Visualize some digramms if needed.
#tradeoffs - most likely there are a few options available for design options, frameworks or libraries. Do not keep it high level. Make a solid research. Provide links, pros and cons for every option. If the library is deprecated - point it out.
#bestpractices - the topic is unknown to me. Please do more exploration and provide the best industry practices for this problem.

In summary, try to build a roadmap for incoming work, I can parallelize a work across different teams or engineers.
The document should be look as it was written by a real software engineer. Code and configration snippets as examples are welcome.

Format guidelines:
1. avoid table representation, use simple lists instead.
2. Use simple lists to demonstrate pros and cons for different options.
3. if you visualize a digramm, always list every step in a plint text (list view) under the digramm.
4. Avoid "you" pronoun, you're a part of the team, use "we" instead.
5. Every UML digram should be represented in plantuml format.
6. Avoid exaggeration selling speech in text. Sounds natural. Avoid words like: "dramatically", "huge", "delivering value", "significantly", "agile".]],
}

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function()
      require("CopilotChat").setup({
        model = "claude-opus-4",
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
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-CR>",
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
          "<leader>aC",
          function()
            copilot_chat.open({ context = "files:" .. vim.fn.getcwd() .. "/*" })
          end,
          desc = "CopilotChat cwd",
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
            copilot_chat.toggle()
          end,
          desc = "CopilotChat toggle",
          mode = { "n", "v", "i" },
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
            local prompt = [[List diagnostic messages in the current file and provide a solution for each of them.
Look around in the current working directory to get hints. Try to reuse existing code if possible.
Pay attention in missing imports and dependencies. If you find any undefined variables, functions or types, suggest how to define them.
Validate you changes before proposing the final solution.]]
            copilot_chat.ask(prompt, { context = "buffer:current\n> #filenames:*\n> #files:" .. vim.fn.getcwd() .. "/*" })
          end,
          desc = "Diagnostic Fixes",
          mode = { "n", "v" },
        },
        {
          "<leader>ae",
          function()
            local prompt = "This code didn't work as expected. When I run the program I recieved a runtime error.\nReview this runtime error message and propose a solution:\n"
            local last_error_message = Tricks.noice_last_error_copy()
            if last_error_message == "" then
              LazyVim.warn("No runtime error message found in noice", { title = "CopilotChat", level = "warn" })
              return
            end

            copilot_chat.ask(prompt .. "```\n" .. last_error_message .. "\n```")
          end,
          desc = "Fix Runtime Error",
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
          function()
            copilot_chat.stop()
            vim.cmd("stopinsert")
          end,
          desc = "CopilotChat Stop",
          mode = { "n", "v" },
        },
        {
          "<leader>ay",
          function()
            local response = require("CopilotChat").response()
            vim.fn.setreg("+", response, "c") -- Use the + register for system clipboard
            LazyVim.notify("Yanked Copilot Response", { title = "CopilotChat", level = "info" })
          end,
          desc = "Yank Copilot Response",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
