return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>ft",
        function()
          Snacks.explorer()
        end,
        desc = "Snacks Explorer",
      },
    },
  },
}
