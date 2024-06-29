return {
  {
    "ThePrimeagen/harpoon",
    -- stylua: ignore
    keys = {
      { "<leader>h", function()
        require("harpoon"):list():add()
        LazyVim.info("Harpooned " .. vim.fn.expand("%:h:p"), { title = "Harpoon" })
      end, desc = "Harpoon File" },
      { "<leader>wh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu"},
      { "@", function() require("harpoon"):list():prev() end, desc = "Prev Harpoon"},
      { "!", function() require("harpoon"):list():next() end, desc = "Next Harpoon"},
      { "<leader>H", false },
      { "<leader>2", false },
      { "<leader>3", false },
      { "<leader>4", false },
      { "<leader>5", false },
    },
  },
}
