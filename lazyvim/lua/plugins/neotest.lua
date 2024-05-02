return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
    },
    -- stylua: ignore
    keys = {
      { "<leader>tr", function() 
              require("neotest").run.run()
              require("neotest").summary.open()
            end, desc = "Run Nearest", },

      { "<leader>tt", function() 
        require("neotest").run.run(vim.fn.expand("%"))
        require("neotest").summary.open()
      end, desc = "Run File", },

      { "<leader>tT", function() 
        require("neotest").run.run({ suite = true }) 
        require("neotest").summary.open()
      end, desc = "Run All Test Files", },

      { "<leader>tl", function() 
        require("neotest").run.run_last() 
        require("neotest").summary.open()
      end, desc = "Run Last Test", },

      { "<leader>tL", function() 
        require("neotest").run.run_last({ strategy = "dap" }) 
        require("neotest").summary.open()
      end, desc = "Debug Last Test", },

      { "<leader>tw", "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>", desc = "Run Watch", },
      { "<leader>tu", function() require("neotest").summary.toggle() end, desc = "Toggle Summary UI" },
      { "<C-S-T>", function() require("neotest").summary.toggle() end, desc = "Toggle Summary UI" },
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
    end,
  },
}
