return {
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F1>", function() require("dap").step_into() end, { desc = "Step Into" }, },
      { "<F2>", function() require("dap").step_over() end, { desc = "Step Over" }, },
      { "<F3>", function() require("dap").step_back() end, { desc = "Step Back" }, },
      { "<F4>", function() require("dap").run_to_cursor() end, { desc = "Run to Cursor" }, },
      { "<F5>", function() require("dap").continue() end, { desc = "Continue" }, },
      { "<F6>", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" }, },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    -- stylua: ignore
    keys = {
      { "<F7>", function() require("dapui").eval() end, { desc = "Evaluate" },
      },
    },
  },
}
