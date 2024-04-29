return {
  "nvim-treesitter/nvim-treesitter",
  lazy = true,
  -- override existing event rule insted of merging
  event = function(_, event)
    return { "LazyFile" } -- { "BufRead" },
  end,
  opts = function(_, opts)
    table.insert(opts.ensure_installed, {
      "http",
      "graphql",
      "jsonc",
    })
  end,
}
