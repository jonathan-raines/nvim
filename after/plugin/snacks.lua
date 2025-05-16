MiniDeps.add { source = 'folke/snacks.nvim' }

MiniDeps.later(function()
  require 'snacks'.setup {
    indent = { enabled = true },
    notifier = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    picker = {
      formatters = {
        file = {
          truncate = 60
        }
      },
      win = {
        input = {
          keys = {
            ["<c-t>"] = { "edit_tab", mode = { "i", "n" } }
          }
        }
      }
    }
  }

  local keymaps = {
    --  ╭─────────────────────────────────────────────────────────╮
    --  │                     Explorer                            │
    --  ╰─────────────────────────────────────────────────────────╯
    { 'n',          "<leader>fe",      function() Snacks.explorer() end,                                                                                                  { desc = "File Explorer" } },
    --  ╭─────────────────────────────────────────────────────────╮
    --  │                     Git                                 │
    --  ╰─────────────────────────────────────────────────────────╯
    { 'n',          '<leader>gg',      function() Snacks.lazygit() end,                                                                                                   { desc = 'Lazygit' } },
    { 'n',          '<leader>gf',      function() Snacks.lazygit.log_file() end,                                                                                          { desc = 'Lazygit Current File History' } },
    { 'n',          '<leader>gl',      function() Snacks.lazygit.log() end,                                                                                               { desc = 'Lazygit Log (cwd)' } },
    { 'n',          "<leader>fh",      function() Snacks.picker.git_status() end,                                                                                         { desc = "Git Status" } },
    --  ╭─────────────────────────────────────────────────────────╮
    --  │                     Picker                              │
    --  ╰─────────────────────────────────────────────────────────╯
    { 'n',          '<leader><space>', function() Snacks.picker() end,                                                                                                    { desc = 'Pickers' } },
    { 'n',          "<leader>:",       function() Snacks.picker.command_history() end,                                                                                    { desc = "Command History" } },
    { 'n',          "<leader>/",       function() Snacks.picker.grep() end,                                                                                               { desc = "Grep" } },
    { 'n',          "<leader>f/",      function() Snacks.picker.lines() end,                                                                                              { desc = "Buffer Lines" } },
    { 'n',          "<leader>bl",      function() Snacks.picker.buffers() end,                                                                                            { desc = "Buffers" } },
    { 'n',          "<leader>fa",      function() Snacks.picker.smart { filter = { cwd = vim.fn.getcwd() }, multi = { "buffers", "recent", "files", "git_status" } } end, { desc = "Smart" } },
    { 'n',          "<leader>fb",      function() Snacks.picker.grep_buffers() end,                                                                                       { desc = "Grep Open Buffers" } },
    { 'n',          "<leader>fc",      function() Snacks.picker.commands() end,                                                                                           { desc = "Commands" } },
    { 'n',          "<leader>fC",      function() Snacks.picker.colorschemes() end,                                                                                       { desc = "Colorschemes" } },
    { 'n',          '<leader>ff',      function() Snacks.picker.files() end,                                                                                              { desc = 'Files' } },
    { 'n',          "<leader>fo",      function() Snacks.picker.recent { filter = { cwd = vim.fn.getcwd() } } end,                                                        { desc = "Recent" } },
    { 'n',          "<leader>fr",      function() Snacks.picker.resume() end,                                                                                             { desc = "Resume" } },
    { { "n", "x" }, "<leader>fw",      function() Snacks.picker.grep_word() end,                                                                                          { desc = "Visual selection or word" } },
    --  ╭─────────────────────────────────────────────────────────╮
    --  │                     Terminal                            │
    --  ╰─────────────────────────────────────────────────────────╯
    { { 'n', 't' }, '<c-\\>',          function() Snacks.terminal() end,                                                                                                  { desc = 'Toggle Terminal' } },
  }

  for _, val in pairs(keymaps) do
    vim.keymap.set(val[1], val[2], val[3], vim.tbl_extend('force', {}, val[4]))
  end

  vim.cmd([[au FileType snacks_picker_input lua vim.b.minicompletion_disable = true]])
end)
