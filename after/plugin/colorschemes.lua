local add, now = MiniDeps.add, MiniDeps.now

add { source = 'folke/tokyonight.nvim' }
add { source = 'Mofiqul/dracula.nvim' }

now(function()
  require 'tokyonight'.setup { transparent = true }

  require 'dracula'.setup { transparent_bg = true }
end)

now(function()
  vim.cmd.colorscheme 'tokyonight'
end)
