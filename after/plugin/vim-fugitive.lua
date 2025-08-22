vim.pack.add({ "https://github.com/tpope/vim-fugitive" }, { load = true })

vim.keymap.set('n', '<leader>gs', [[:tab Git<CR>]], { desc = '[Git] Status' })
