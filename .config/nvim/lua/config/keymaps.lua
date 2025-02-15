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

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

-- Nvim tree
vim.keymap.set('n', '<leader>tt', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', '<leader>to', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', function()
  require("nvim-tree.api").tree.find_file({
    update_root = true,
    open = true,
    focus = false,
  })
end)

-- Tests with vim-rails
vim.keymap.set('n', '<leader>rt', ':.Rails<CR>')
vim.keymap.set('n', '<leader>rqt', ':.Rails!<CR>')
vim.keymap.set('n', '<leader>rs', ':Rails<CR>')
vim.keymap.set('n', '<leader>rqs', ':Rails!<CR>')
vim.keymap.set('n', '<leader>rr', ':Copen|Dispatch<CR>')

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

