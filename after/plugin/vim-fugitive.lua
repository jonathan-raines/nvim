MiniDeps.add { source = "tpope/vim-fugitive" }

MiniDeps.later(function()
  vim.keymap.set('n', '<leader>gs', [[:tab Git<CR>]], { desc = '[Git] Status' })
end)
