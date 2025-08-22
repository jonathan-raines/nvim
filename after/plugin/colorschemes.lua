local add, now = MiniDeps.add, MiniDeps.now

add { source = 'folke/tokyonight.nvim' }
add { source = 'Mofiqul/dracula.nvim' }
add { source = 'sainnhe/sonokai' }
add { source = 'EdenEast/nightfox.nvim' }

now(function()
  require 'tokyonight'.setup { transparent = true }

  require 'dracula'.setup { transparent_bg = true }

  -- `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`,
  vim.g.sonokai_style = 'atlantis'
  vim.g.sonokai_transparent_background = true

  vim.cmd.colorscheme 'nightfox'
end)
