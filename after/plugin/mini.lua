MiniDeps.now(function()
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Files                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.files'.setup {
    options = { use_as_default_explorer = true }
  }

  vim.keymap.set('n', '<leader>e', function()
    require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
  end, { desc = 'File Explorer' })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Icons                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.icons'.setup {}
  require 'mini.icons'.mock_nvim_web_devicons()

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Statusline                     │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.statusline'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.SplitJoin                      │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.splitjoin'.setup {}
end)

MiniDeps.later(function()
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Completion                     │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.completion'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.IndentScope                    │
  --  ╰─────────────────────────────────────────────────────────╯
  -- require 'mini.indentscope'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Surround                       │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.surround'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Pairs                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.pairs'.setup {
    modes = { insert = true, command = true, terminal = false }
  }

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Git                            │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.git'.setup {}
  vim.keymap.set("n", "<leader>hc", function() require 'mini.git'.show_at_cursor() end, { desc = "Show at Cursor" })
  vim.keymap.set("n", "<leader>hh", function() require 'mini.git'.show_range_history() end, { desc = "Range History" })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.HiPatterns                     │
  --  ╰─────────────────────────────────────────────────────────╯
  local hipatterns = require("mini.hipatterns")

  local censor_extmark_opts = function(_, match, _)
    local mask = string.rep("*", vim.fn.strchars(match))
    return {
      virt_text = { { mask, "Comment" } },
      virt_text_pos = "overlay",
      priority = 200,
      right_gravity = false,
    }
  end

  local password_table = {
    pattern = {
      "password: ()%S+()",
      "password_usr: ()%S+()",
      "_pw: ()%S+()",
      "password_asgard_read: ()%S+()",
      "password_elara_admin: ()%S+()",
      "gpg_pass: ()%S+()",
      "passwd: ()%S+()",
      "secret: ()%S+()",
    },
    group = "",
    extmark_opts = censor_extmark_opts,
  }

  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
      hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
      todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
      note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

      -- Cloaking Passwords
      pw = password_table,

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
  vim.keymap.set("n", "<leader>tp", function()
    if next(hipatterns.config.highlighters.pw) == nil then
      hipatterns.config.highlighters.pw = password_table
    else
      hipatterns.config.highlighters.pw = {}
    end
    vim.cmd("edit")
  end, { desc = "Toggle Password Cloaking" })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.IndentScope                    │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.indentscope'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Pick                           │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.pick'.setup {}
  require 'mini.extra'.setup {}
  vim.keymap.set('n', '<c-p>', function() vim.cmd('Pick files') end, { desc = '[PICK] - Files' })
  vim.keymap.set('n', '<leader>o', function() vim.cmd('Pick oldfiles current_dir=true') end,
    { desc = '[PICK] - Oldfiles' })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Surround                       │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.surround'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Visits                         │
  --  ╰─────────────────────────────────────────────────────────╯
  local visits = require 'mini.visits'
  visits.setup {}

  vim.keymap.set('n', '<leader>vv', function() visits.add_label("core") end, { desc = 'Add to core' })
  vim.keymap.set('n', '<leader>vV', function() visits.remove_label("core") end, { desc = 'Remove from core' })
  vim.keymap.set('n', '<leader>vc', function() visits.select_path("", { filter = "core" }) end, { desc = 'Sel All' })
  vim.keymap.set('n', '<leader>vC', function() visits.select_path(nil, { filter = "core" }) end, { desc = 'Sel CWD' })
end)
