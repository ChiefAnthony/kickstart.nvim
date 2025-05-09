return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      views = {
        cmdline_popup = {
          border = {
            style = 'none',
            padding = { 1, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
        notify = {
          border = {
            style = 'none',
            padding = { 0, 0 },
          },
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat',
          },
        },
      },
      cmdline = {
        format = {
          search_down = {
            view = 'cmdline',
          },
          search_up = {
            view = 'cmdline',
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },
}
