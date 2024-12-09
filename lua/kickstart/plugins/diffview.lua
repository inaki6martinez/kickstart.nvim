return {
  {
    'sindrets/diffview.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>vo', ':DiffviewOpen', { desc = 'Diff[V]iew [O]pen' })
      vim.keymap.set('n', '<leader>vh', ':DiffviewFileHistory %<CR>', { desc = 'Diff[V]iew file [H]istory' })
      vim.keymap.set('n', '<leader>vc', ':DiffviewClose<CR>', { desc = 'Diff[V]iew [C]clos' })
    end,
  },
}
