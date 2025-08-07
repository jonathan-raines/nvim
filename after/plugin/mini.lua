vim.pack.add { 'https://github.com/echasnovski/mini.nvim' }

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Completion                     │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.completion'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Diff                           │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.diff'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Icons                          │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.icons'.setup {}
require 'mini.icons'.mock_nvim_web_devicons()

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Indentscope                    │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.indentscope'.setup {}

--  ╭─────────────────────────────────────────────────────────╮
--  │                     Mini.Pick                           │
--  ╰─────────────────────────────────────────────────────────╯
require 'mini.pick'.setup {}
require 'mini.extra'.setup {}
vim.keymap.set('n', '<leader>pd', function() vim.cmd.Pick 'diagnostic' end, { desc = '[Pick] Diagnostic' })
vim.keymap.set('n', '<leader>pf', function() vim.cmd.Pick 'files' end, { desc = '[Pick] Files' })
vim.keymap.set('n', '<leader>po', function() vim.cmd('Pick oldfiles current_dir=true') end, { desc = '[Pick] Old Files' })
vim.keymap.set('n', '<leader>pe', function() vim.cmd.Pick 'explorer' end, { desc = '[Pick] Explorer' })
vim.keymap.set('n', '<leader>ps', function() vim.cmd("Pick lsp scope='document_symbol'") end, { desc = '[Pick] Symbols' })
vim.keymap.set('n', '<leader>p/', function() vim.cmd.Pick 'buf_lines' end, { desc = '[Pick] Grep Buffer' })
-- vim.keymap.set('n', '<leader>/', function() vim.cmd.Pick 'grep_live' end, { desc = '[Pick] Grep' })

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
