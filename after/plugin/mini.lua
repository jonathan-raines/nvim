MiniDeps.now(function()
  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Files                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.files'.setup {}

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
  --  │                     Mini.Surround                       │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.surround'.setup {}

  --  ╭─────────────────────────────────────────────────────────╮
  --  │                     Mini.Pairs                          │
  --  ╰─────────────────────────────────────────────────────────╯
  require 'mini.pairs'.setup {
    modes = { insert = true, command = true, terminal = false }
  }
end)
