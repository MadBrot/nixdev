return {
  "okuuva/auto-save.nvim",
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    execution_message = {
      enabled = false,
    },

    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave" },
      cancel_deferred_save = { "InsertEnter" },
    },

    condition = function(buf)
      return vim.bo[buf].modifiable
    end,

    debounce_delay = 5000,
  },
}
