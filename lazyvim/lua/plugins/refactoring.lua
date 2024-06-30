return {
  "ThePrimeagen/refactoring.nvim",
  event = function()
    return {}
  end,
  -- stylua: ignore
  -- M.refactor_names = {
  --   ["Inline Variable"] = "inline_var",
  --   ["Extract Variable"] = "extract_var",
  --   ["Extract Function"] = "extract",
  --   ["Extract Function To File"] = "extract_to_file",
  --   ["Extract Block"] = "extract_block",
  --   ["Extract Block To File"] = "extract_block_to_file",
  --   ["Inline Function"] = "inline_func",
  -- }

  keys = {
    { "<leader>rs", mode = { "v" }, false },
    { "<leader>rx", mode = { "v" }, false },
    { "<leader>rm", function() require("refactoring"):select_refactor() end, mode = { "n", "x" }, desc = "Refactor Menu", },
    { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = { "x" }, desc = "Extract Variable", },
    { "<leader>rI", function() require("refactoring").refactor("Inline Function") end, mode = { "x" }, desc = "Inline Function", },
  },
}
