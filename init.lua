--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)
--
-- Set autoindent to copy indentation from previous line
vim.opt.autoindent = true

-- Set smartindent
vim.opt.smartindent = true
vim.opt.copyindent = true

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', multispace = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Decent wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full'
vim.opt.wildignorecase = true
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- replace
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
--vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Search results at the middle of the screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Copy paste into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>P', '"+P')
vim.keymap.set('x', '<leader>p', '"_dP')

-- Pointer arrow
vim.keymap.set('i', 'kk', '->')

-- Save when pressing zz
vim.keymap.set('n', 'zz', ':update<CR>', { noremap = true, silent = true })

-- Enter normal mode with jj
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- Switch between souce and header
-- vim.keymap.set('n', '<leader>h', ':ClangdSwitchSourceHeader<CR>', { noremap = true, silent = true })

-- Move tabs
vim.keymap.set('n', 'H', 'gT')
vim.keymap.set('n', 'L', 'gt')

-- Move text in blocks
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Leave the cursor at the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- set same size to all windows
vim.keymap.set('n', '<leader>w', '<C-w>=')

-- Difffiles
vim.keymap.set('n', '<leader>dt', vim.cmd.diffthis, { desc = '[D]iff [T]his file' })
vim.keymap.set('n', '<leader>do', vim.cmd.diffoff, { desc = '[D]iff [O]ff file' })
vim.keymap.set('n', '<leader>dr', vim.cmd.diffg, { desc = '[D]iff [R]ead this changes' })
vim.keymap.set('n', '<leader>dw', vim.cmd.diffpu, { desc = '[D]iff [W]rite this changes' })
vim.keymap.set('n', '<leader>dp', '[c', { desc = '[D]iff [P]revious change' })
vim.keymap.set('n', '<leader>dn', ']c', { desc = '[D]iff [N]ext change' })

-- C macros
vim.api.nvim_set_keymap('n', '<leader>mo', 'O#ifdef ', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>mc', 'o#endif <ESC>b%2wv$hy%A/* <ESC>pA */<ESC>', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Cursorline disble when leaving buffer
local cursorGrp = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
  pattern = { '*' },
  callback = function()
    vim.opt.cursorline = true
  end,
  desc = 'Enable cursorline when entering file',
  group = cursorGrp,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  pattern = { '*' },
  callback = function()
    vim.opt.cursorline = false
  end,
  desc = 'Enable cursorline when entering file',
  group = cursorGrp,
})

local columnGrop = vim.api.nvim_create_augroup('ColorColumn', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
  pattern = { '*.c', '*.h' },
  callback = function()
    vim.opt.colorcolumn = '80'
  end,
  desc = 'Enable colorcolumn at 80 for C/C++ files',
  group = columnGrop,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  pattern = { '*' },
  callback = function()
    vim.opt.colorcolumn = ''
  end,
  desc = 'Disable column for all files',
  group = columnGrop,
})

-- Relative number on active buffer, normal on others
local numberGrp = vim.api.nvim_create_augroup('LineNumber', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
  group = numberGrp,
  desc = 'Activate relativenumber when entering buffer',
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
  group = numberGrp,
  desc = 'Disable relativenumber when entering buffer',
})

-- Stop LSP if the global variable is set to false

Disabled_lsp = false
local lspGrp = vim.api.nvim_create_augroup('LSPstop', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter', 'BufReadPost' }, {
  pattern = { '*.c', '*.h' },
  callback = function(opts)
    --print('Triggered event: ' .. opts.event)
    if Disabled_lsp then
      vim.lsp.stop_client(vim.lsp.get_clients())
    end
  end,
  group = lspGrp,
  desc = 'Stop LSP when entering C/C++ file',
})

vim.keymap.set('n', '<leader>ls', ':lua Disabled_lsp = true<CR>:e<CR>', { silent = true, desc = '[L]SP [S]top' })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Split resize
  {
    'talek/obvious-resize',
    config = function()
      vim.keymap.set('n', '<C-right>', ':<C-U>ObviousResizeRight<CR>', { silent = true })
      vim.keymap.set('n', '<C-left>', ':<C-U>ObviousResizeLeft<CR>', { silent = true })
      vim.keymap.set('n', '<C-up>', ':<C-U>ObviousResizeUp<CR>', { silent = true })
      vim.keymap.set('n', '<C-down>', ':<C-U>ObviousResizeDown<CR>', { silent = true })
    end,
  },

  -- Tabnine
  --{ 'codota/tabnine-nvim', build = './dl_binaries.sh' },

  -- Coment visual regions/lines with "gc"
  { 'numToStr/Comment.nvim', opts = {} },

  -- Remember last buffer postion
  {
    'vladdoster/remember.nvim',
    config = function()
      require 'remember'
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },

  -- Clipboard
  { 'tmux-plugins/vim-tmux-focus-events' },
  { 'roxma/vim-tmux-clipboard' },

  {
    'iamcco/markdown-preview.nvim',
    event = 'VeryLazy',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.codeium',
  require 'kickstart.plugins.diffview',
  require 'kickstart.plugins.fugitive',
  require 'kickstart.plugins.fterm',
  require 'kickstart.plugins.tmux_navigation',
  require 'kickstart.plugins.leap',
  require 'kickstart.plugins.which_key',
  require 'kickstart.plugins.telescope',
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.autocomplete',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.treesitter',
  -- require 'kickstart.plugins.gitlabduo',
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require('header_source').setup()

-- Tabnine config
--require('tabnine').setup {
--  disable_auto_comment = true,
--  accept_keymap = '<Right>',
--  dismiss_keymap = '<C-x>',
--  debounce_ms = 800,
--  suggestion_color = { gui = '#808080', cterm = 244 },
--  exclude_filetypes = { 'TelescopePrompt', 'NvimTree', 'txt', 'text' },
--  log_file_path = nil, -- absolute path to Tabnine log file
--  ignore_certificate_errors = false,
--}

local fterm = require 'FTerm'

local lazygit = fterm:new {
  ft = 'fterm_lazygit',
  cmd = 'lazygit',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
}

vim.keymap.set('n', '<leader>lg', function()
  lazygit:toggle()
end)

-- Scratch terminals are awesome because you can do this
vim.api.nvim_create_user_command('Lazygit', function()
  require('FTerm').scratch { cmd = { 'lazygit' } }
end, { bang = true })

-- Function to toggle the LSP
function ToggleLSP()
  if vim.g.lsp_auto_attach then
    -- Disable LSP
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      vim.lsp.stop_client(client.id)
    end
    vim.g.lsp_auto_attach = false
    print 'LSP disabled'
  else
    -- Enable LSP
    vim.g.lsp_auto_attach = true
    vim.cmd 'LspStart'
    print 'LSP enabled'
  end
end

vim.api.nvim_set_keymap('n', '<leader>tl', ':lua ToggleLSP()<CR>', { noremap = true, silent = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
