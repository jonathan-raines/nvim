vim.pack.add {
  'https://github.com/ibhagwan/fzf-lua'
}

require 'fzf-lua'.setup {
  winopts = { height = 0.6, row = 1.0, col = 0.0 },
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    }
  },
  oldfiles = {
    include_current_session = true,
  },
  previewers = {
    builtin = {
      syntax_limit_b = 1024 * 100, -- 100KB
    },
  }
}

require("fzf-lua").register_ui_select()

local keymaps = {
  { 'n', '<leader><leader>', vim.cmd.FzfLua,                                            { desc = '[FzfLua] Pickers' } },
  { 'n', '<leader>fb',       function() vim.cmd.FzfLua 'buffers' end,                   { desc = '[FzfLua] Buffers' } },
  { 'n', '<leader>fc',       function() vim.cmd.FzfLua 'colorschemes' end,              { desc = '[FzfLua] Colorschemes' } },
  { 'n', '<leader>fd',       function() vim.cmd.FzfLua 'lsp_document_diagnostics' end,  { desc = 'Document diagnostics' } },
  { 'n', '<leader>fD',       function() vim.cmd.FzfLua 'lsp_workspace_diagnostics' end, { desc = 'Workspace diagnostics' } },
  { 'n', '<leader>ff',       function() vim.cmd.FzfLua 'files' end,                     { desc = '[FzfLua] Find Files' } },
  { 'n', '<leader>fh',       function() vim.cmd.FzfLua 'git_status' end,                { desc = '[FzfLua] Git Status' } },
  { 'n', '<leader>fo',       function() vim.cmd('FzfLua oldfiles cwd_only=true') end,   { desc = '[FzfLua] Old Files' } },
  { 'n', '<leader>fr',       function() vim.cmd.FzfLua 'resume' end,                    { desc = '[FzfLua] Resume' } },
  { 'n', '<leader>ft',       function() vim.cmd.FzfLua 'tabs' end,                      { desc = '[FzfLua] Tabs' } },
  { 'n', '<leader>fw',       function() vim.cmd.FzfLua 'grep_cword' end,                { desc = '[FzfLua] Grep Word' } },
  { 'n', '<leader>fW',       function() vim.cmd.FzfLua 'grep_cWORD' end,                { desc = '[FzfLua] Grep WORD' } },
  { 'n', '<leader>f/',       function() vim.cmd.FzfLua 'blines' end,                    { desc = '[FzfLua] Grep Buffer' } },
  { 'n', '<leader>/',        function() vim.cmd.FzfLua 'live_grep_native' end,          { desc = '[FzfLua] Live Grep' } },
}

for _, val in pairs(keymaps) do
  vim.keymap.set(val[1], val[2], val[3], vim.tbl_extend('force', {}, val[4]))
end
