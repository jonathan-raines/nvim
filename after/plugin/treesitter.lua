vim.pack.add { { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' } }

local ts_parsers = {
  "bash",
  "c",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "html",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "python",
  'ruby',
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vue",
  "yaml",
  "zig",
}

local treesitter = require("nvim-treesitter")
treesitter.install(ts_parsers)

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup("treesitter.update", { clear = true }),
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.notify("nvim-treesitter was updated, running :TSUpdate", vim.log.levels.INFO)
      vim.schedule(function()
        treesitter.update()
      end)
    end
  end
})

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
    vim.treesitter.start()

    -- replicate `indent = { enable = true }`
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
})
