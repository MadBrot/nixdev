return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = false,
    },
  },
  init = function()
    -- Prevent Snacks from auto-opening on directory
    vim.api.nvim_del_augroup_by_name("snacks_dashboard")
  end,
}
