-- disable netrw at the very start of your init.lua for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup defaults
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.nu = true
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.scrolloff = 5
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.cursorline = true
vim.o.termguicolors = true
vim.keymap.set('n', '<esc>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Copy relative, absolute and directory path
vim.keymap.set('n', '<leader>cr', ':let @+=expand("%")<CR>')
vim.keymap.set('n', '<leader>cp', ':let @+=expand("%:p")<CR>')
vim.keymap.set('n', '<leader>cd', ':let @+=expand("%:p:h")<CR>')
-- Move lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Copilot
vim.keymap.set('i', '<c-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<c-]>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<c-J>', 'copilot#Accept("\\<CR>")', {
--   expr = true,
--   replace_keycodes = false
-- })
-- vim.g.copilot_no_tab_map = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})

-- require('onedark').setup {
    -- style = 'darker'
-- }
-- require('onedark').load()
-- vim.cmd.colorscheme "onedark"

vim.o.termguicolors = true
vim.cmd.colorscheme "everforest"

require('lualine').setup()

require 'config.telescope'
require 'config.treesitter'
require 'config.clipboard'
require 'config.test_alternative'
require 'config.yank_highlight'
