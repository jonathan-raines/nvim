vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }
vim.pack.add { 'https://github.com/EdenEast/nightfox.nvim' }
vim.pack.add { 'https://github.com/loctvl842/monokai-pro.nvim' }

require("monokai-pro").setup { transparent_background = true }

vim.cmd.colorscheme 'monokai-pro-spectrum'
