return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave" },
  opts = {
    enabled = true,
    execution_message = {
      enabled = false,
    },
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" },
      defer_save = { "InsertLeave" },
      cancel_deferred_save = { "InsertEnter" },
    },
    condition = function(buf)
      local fn = vim.fn
      local utils = require("auto-save.utils.data")

      if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
        return true
      end
      return false
    end,
    write_all_buffers = false,
    debounce_delay = 135,
  },
}
