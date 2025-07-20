vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }

vim.keymap.set('n', '<leader>do', vim.cmd.DiffviewOpen, { desc = '[Diffview] Open' })
vim.keymap.set('n', '<leader>dc', vim.cmd.DiffviewClose, { desc = '[Diffview] Close' })
vim.keymap.set('n', '<leader>df', function() vim.cmd.DiffviewFileHistory '%' end, { desc = '[Diffview] File History' })
vim.keymap.set('n', '<leader>dh', vim.cmd.DiffviewFileHistory, { desc = '[Diffview] History' })
