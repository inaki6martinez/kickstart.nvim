return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
      --vim.keymap.set("n", "<leader>gw", vim.cmd.Gwrite)
      --vim.keymap.set("n", "<leader>gr", vim.cmd.Gread)
      vim.keymap.set('n', '<leader>gd', vim.cmd.Gdiff)
      vim.keymap.set('n', '<leader>gb', ':Git blame -C -C -C <CR>', { silent = true })
    end,
  },
}
