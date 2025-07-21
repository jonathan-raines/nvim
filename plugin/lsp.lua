--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSPAttach                           │
--  ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    local methods = vim.lsp.protocol.Methods

    local function keymap(lhs, rhs, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    keymap('<leader>ls', function() vim.lsp.stop_client(vim.lsp.get_clients()) end, 'Stop LSP Servers')

    if client:supports_method(methods.textDocument_documentSymbol) then
      keymap("<leader>fs", function() vim.cmd.FzfLua 'lsp_document_symbols' end, "LSP Symbols")
    end

    if client:supports_method(methods.textDocument_inlayHint) then
      keymap('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }))
      end, 'Inlay Hints')
    end

    if client:supports_method(methods.textDocument_formatting) or client.name == 'solargraph' then
      if client.name ~= 'tsserver' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end,
        })

        keymap('<leader>lf', vim.lsp.buf.format, 'Diagnostic Local List')
      end
    end

    if client:supports_method(methods.textDocument_completion) then
      local chars = {}
      for i = 32, 126 do
        table.insert(chars, string.char(i))
      end

      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end
  end,
})

--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSPDetach                           │
--  ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    local methods = vim.lsp.protocol.Methods

    if client:supports_method(methods.textDocument_formatting) then
      vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        buffer = args.buf,
      })
    end

    if client:supports_method(methods.textDocument_documentSymbol) then
      vim.keymap.del('n', '<leader>fs', { buffer = args.buf })
    end

    -- Inlay Hints
    if client:supports_method(methods.textDocument_inlayHint) then
      vim.keymap.del('n', '<leader>lh', { buffer = args.buf })
    end

    if client:supports_method(methods.textDocument_completion) then
      vim.lsp.completion.enable(false, client.id, args.buf)
    end
  end
})

--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSP Servers                         │
--  ╰─────────────────────────────────────────────────────────╯
vim.lsp.enable({ "bashls", "eslint", "jsonls", "lua_ls", "marksman", "solargraph", "ts_ls", "vuels", "yamlls" })
