return {
  {
    "hsalem7/nvim-k8s",
    lazy = true,
    -- stylua: ignore
    keys = {
      { "<Leader>k8", function() require("nvim-k8s.K8s"):toggle() end, desc = "Toggle K8s", },
    },
  },
}
