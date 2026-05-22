return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    {
      "<leader>ft",
      "<cmd>Neotree toggle<cr>",
      desc = "NeoTree",
    },
  },

  opts = {
    filesystem = {
      hijack_netrw_behavior = "disabled",

      follow_current_file = {
        enabled = false,
      },
    },
  },
}
