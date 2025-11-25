return {
    -- メインのLSP設定
    'neovim/nvim-lspconfig',
    dependencies = { -- LSPと関連ツールを自動的にインストール
    {
        'williamboman/mason.nvim',
        config = true
    }, -- 注意: 依存プラグインより先にロードする必要があります
    'williamboman/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- LSPのステータス更新に便利
    {
        'j-hui/fidget.nvim',
        opts = {}
    }, -- nvim-cmpによる追加機能を提供
    'hrsh7th/cmp-nvim-lsp'},
    config = function()
        -- LSPが特定のバッファにアタッチされたときに実行される関数
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', {
                clear = true
            }),
            callback = function(event)
                -- ヘルパー関数を定義して、LSP関連のマッピングを簡単に設定
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, {
                        buffer = event.buf,
                        desc = 'LSP: ' .. desc
                    })
                end

                -- 定義へジャンプ
                map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- 参照を検索
                map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- 実装へジャンプ
                map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- 型定義へジャンプ
                map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

                -- ドキュメント内のシンボルをファジー検索
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

                -- ワークスペース内のシンボルをファジー検索
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- 変数名をリネーム
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- コードアクションを実行
                map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', {'n', 'x'})

                -- 宣言へジャンプ
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- カーソル下の単語の参照をハイライト表示
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', {
                        clear = false
                    })
                    vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight
                    })

                    vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', {
                            clear = true
                        }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds {
                                group = 'lsp-highlight',
                                buffer = event2.buf
                            }
                        end
                    })
                end

                -- インレイヒントのトグルキーを設定
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
                            bufnr = event.buf
                        })
                    end, '[T]oggle Inlay [H]ints')
                end
            end
        })

        -- LSPサーバーとクライアントがサポートする機能を設定
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- 使用するLSPサーバーを設定
        local servers = {
            -- LSPサーバーの設定例
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            lua_ls = {
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = 'Replace'
                        }
                        -- 不要な警告を無効化する場合
                        -- diagnostics = { disable = { 'missing-fields' } },
                    }
                }
            }
        }

        -- Masonをセットアップ
        require('mason').setup()

        -- 必要なツールをインストール
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {'stylua' -- Luaコードのフォーマッタ
        })
        require('mason-tool-installer').setup {
            ensure_installed = ensure_installed
        }

        require('mason-lspconfig').setup {
            handlers = {function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                require('lspconfig')[server_name].setup(server)
            end}
        }
    end
}
