return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'fzf-lua'.setup {
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept"
        }
      }
    }
  end,
  keys = {
    { '<leader><leader>', vim.cmd.FzfLua,                                                 desc = '[FzfLua] Buffers' },
    { '<leader>fb',       function() vim.cmd.FzfLua 'buffers' end,                        desc = '[FzfLua] Buffers' },
    { '<leader>fc',       function() vim.cmd.FzfLua 'commands' end,                       desc = '[FzfLua] Commands' },
    { '<leader>ff',       function() vim.cmd.FzfLua 'files' end,                          desc = '[FzfLua] Find Files' },
    { '<leader>fk',       function() vim.cmd.FzfLua 'keymaps' end,                        desc = '[FzfLua] Keymaps' },
    { '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                         desc = '[FzfLua] Resume' },
    { '<leader>fo',       function() require('fzf-lua').oldfiles { cwd_only = true } end, desc = '[FzfLua] Old Files' },
    { '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                         desc = '[FzfLua] Resume' },
    { '<leader>ft',       function() vim.cmd.FzfLua 'tabs' end,                           desc = '[FzfLua] Tabs' },
    { '<leader>fw',       function() vim.cmd.FzfLua 'grep_cword' end,                     desc = '[FzfLua] Grep Word' },
    { '<leader>fW',       function() vim.cmd.FzfLua 'grep_cWORD' end,                     desc = '[FzfLua] Grep WORD' },
    { '<leader>f/',       function() vim.cmd.FzfLua 'lgrep_curbuf' end,                   desc = '[FzfLua] Search Buffer' },
    { '<leader>/',        function() vim.cmd.FzfLua 'live_grep_native' end,               desc = '[FzfLua] Live Grep' },
  },
}
