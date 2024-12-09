return {
  {
    'ggandor/leap.nvim',
    config = function()
      --require('leap').add_default_mappings()
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>f', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, '<leader>F', '<Plug>(leap-backward)')
    end,
  },
}
