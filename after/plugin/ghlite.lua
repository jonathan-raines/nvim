MiniDeps.add { source = 'daliusd/ghlite.nvim' }

MiniDeps.later(function()
  require 'ghlite'.setup {
    view_split = '',        -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
    diff_split = '',        -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
    comment_split = '',     -- set to empty string '' to open in active buffer, use 'tabnew' to open in tab
  }
end)
