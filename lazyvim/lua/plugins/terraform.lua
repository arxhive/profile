return {
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    keys = {
      {
        "<leader>sia",
        function()
          local terraform_doc = require("telescope._extensions.terraform_doc.builtin")
          terraform_doc.search({ full_name = "hashicorp/aws" })
        end,
        desc = "Terraform aws",
      },
      {
        "<leader>sim",
        function()
          local terraform_doc = require("telescope._extensions.terraform_doc.builtin")
          terraform_doc.modules({})
        end,
        desc = "Terraform modules",
      },
      {
        "<leader>sit",
        ":Telescope terraform state_list<CR>",
        desc = "Terraform state list",
      },
    },
  },
  { "cappyzawa/telescope-terraform.nvim" },
}
