MiniDeps.add {
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'main',
  hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
}

MiniDeps.later(function()
  local languages = { 'ruby', 'json', 'gitcommit', 'markdown', 'stable' }

  require('nvim-treesitter').install(languages)

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter.setup', {}),
    callback = function(args)
      local buf = args.buf
      local filetype = args.match

      -- you need some mechanism to avoid running on buffers that do not
      -- correspond to a language (like oil.nvim buffers), this implementation
      -- checks if a parser exists for the current language
      local language = vim.treesitter.language.get_lang(filetype) or filetype
      if not vim.treesitter.language.add(language) then
        return
      end

      -- replicate `highlight = { enable = true }`
      vim.treesitter.start(buf, language)

      -- replicate `indent = { enable = true }`
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  })
end
)
