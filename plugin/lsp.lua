--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSPAttach                           │
--  ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    local methods = vim.lsp.protocol.Methods

    -- Keymaps
    local function keymap(lhs, rhs, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    keymap('<leader>li', function() vim.cmd.checkhealth 'lsp' end, 'LSP Info')
    keymap('<leader>ll', vim.diagnostic.setloclist, 'Diagnostic Local List')
    keymap('<leader>ls', function() vim.lsp.stop_client(vim.lsp.get_clients()) end, 'Stop LSP Servers')

    -- Symbols
    if client:supports_method(methods.textDocument_documentSymbol) then
      keymap("<leader>fs", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
    end

    -- Inlay Hints
    if client:supports_method(methods.textDocument_inlayHint) then
      keymap('<leader>lh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }))
      end, 'Inlay Hints')
    end

    if client:supports_method(methods.textDocument_formatting) or client.name == 'solargraph' then
      if client.name ~= 'tsserver' then
        -- Format the current buffer on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          end,
        })

        keymap('<leader>lf', vim.lsp.buf.format, 'Diagnostic Local List')
      end
    end
  end,
})

--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSPDetach                           │
--  ╰─────────────────────────────────────────────────────────╯
vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    -- Get the detaching client
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    local methods = vim.lsp.protocol.Methods

    -- Remove the autocommand to format the buffer on save, if it exists
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
  end
})

--  ╭─────────────────────────────────────────────────────────╮
--  │                     LSP Servers                         │
--  ╰─────────────────────────────────────────────────────────╯
vim.lsp.enable({ "bashls", "eslint", "jsonls", "lua_ls", "marksman", "solargraph", "ts_ls", "vuels", "yamlls" })
