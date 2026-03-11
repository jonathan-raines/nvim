vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Completion                     │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.completion'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Diff                           │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.diff'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Files                          │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.files'.setup {}
vim.keymap.set('n', '<leader>e', '<cmd>lua MiniFiles.open()<CR>', { desc = 'File Explorer' })
vim.keymap.set('n', '-', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>',
  { desc = 'Mini Files Current Directory' })

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Icons                          │
--  ╰─────────────────────────────────────────────────────────╯
local mini_icons = require 'mini.icons'
mini_icons.setup {}
mini_icons.mock_nvim_web_devicons()
mini_icons.tweak_lsp_kind()

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Indentscope                    │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.indentscope'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.SplitJoin                      │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.splitjoin'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Statusline                     │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.statusline'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Surround                       │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.surround'.setup {}
