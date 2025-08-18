vim.pack.add({ 'https://github.com/mbbill/undotree' }, { load = true })

vim.g.undotree_SetFocusWhenToggle = 1

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
