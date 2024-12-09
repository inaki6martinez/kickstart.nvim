return { -- Floating terminal
  {
    'numToStr/Fterm.nvim',
    opts = {},
    config = function()
      -- Fterm shortcuts
      vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
      vim.keymap.set('t', '<C-u>', '<C-\\><C-n><CMD>lua vim.opt.cursorline = true<CR>')
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
      vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end,
  },
}
