return {
  "nvim-mini/mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 50,
      max_number = 30,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        local file = vim.api.nvim_buf_get_name(0)
        require("mini.files").open(file ~= "" and file or vim.uv.cwd(), true)
      end,
      desc = "Explorer (Current File)",
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
