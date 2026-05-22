return {
  "nvim-mini/mini.files",
  lazy = false,
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

        if file == "" or vim.bo.buftype ~= "" or file:match("^minifiles:") then
          require("mini.files").open(vim.uv.cwd(), true)
        end

        require("mini.files").open(file, true)
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
