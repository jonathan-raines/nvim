MiniDeps.add {
  source = "NeogitOrg/neogit",
  depends = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
  }
}

MiniDeps.later(function()
  require 'neogit'.setup {}

  vim.keymap.set('n', '<leader>gn', vim.cmd.Neogit, { desc = '[Neogit] Status' })
end)
