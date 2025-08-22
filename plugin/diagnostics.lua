--  ╭─────────────────────────────────────────────────────────╮
--  │                     Diagnostics                         │
--  ╰─────────────────────────────────────────────────────────╯
vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  underline = true,
  virtual_text = true
})

vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Previous error' })

vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next error' })

vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, { desc = 'Diagnostic Local List' })
