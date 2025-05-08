MiniDeps.now(function()
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Files                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.files'.setup {}

  vim.keymap.set('n', '-', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), true)<CR>', { desc = 'File Explorer' })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Icons                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.icons'.setup {}
  require 'mini.icons'.mock_nvim_web_devicons()

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.SplitJoin                      │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.splitjoin'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Statusline                     │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.statusline'.setup {}
end)

MiniDeps.later(function()
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Completion                     │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.completion'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Diff                           │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.diff'.setup {
    -- view = {
    --   style = "sign",
    --   signs = { add = "█", change = "▒", delete = "" },
    --   signs = { add = '+', change = '~', delete = '-' },
    -- }
  }
  vim.keymap.set("n", "<leader>ht", function() require 'mini.diff'.toggle_overlay() end, { desc = "Toggle Overlay" })

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
  vim.keymap.set('n', '<leader>o', function() vim.cmd('Pick oldfiles current_dir=true') end, { desc = '[PICK] - Oldfiles' })

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Surround                       │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.surround'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Visits                         │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.visits'.setup {}
  local map_vis = function(keys, call, desc)
    local rhs = '<Cmd>lua MiniVisits.' .. call .. '<CR>'
    vim.keymap.set('n', '<Leader>' .. keys, rhs, { desc = desc })
  end

  map_vis('vv', 'add_label("core")', 'Add to core')
  map_vis('vV', 'remove_label("core")', 'Remove from core')
  map_vis('vc', 'select_path("", { filter = "core" })', 'Select core (all)')
  map_vis('vC', 'select_path(nil, { filter = "core" })', 'Select core (cwd)')
end)
