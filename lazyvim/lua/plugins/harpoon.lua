return {
  {
    "ThePrimeagen/harpoon",
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon File" },
      { "<C-S-E>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon Menu"},
      { "<PageUp>", function() require("harpoon"):list():prev() end, desc = "Prev Harpoon"},
      { "<PageDown>", function() require("harpoon"):list():next() end, desc = "Next Harpoon"}
    },
  },
}
