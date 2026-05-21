return {
  "nvim-mini/mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 50,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        require("mini.files").open(vim.fn.getcwd(), true)
      end,
      desc = "Explorer (Root Dir)",
    },
    {
      "<leader>fE",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Explorer (cwd)",
    },
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.fn.getcwd(), true)
      end,
      desc = "Explorer (Root Dir)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Explorer (cwd)",
    },
  },
}
