return {
     -- コードのハイライト、編集、ナビゲーション
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- optsに使用するメインモジュールを設定
    -- Treesitterの設定
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- 未インストールの言語を自動インストール
      auto_install = true,
      highlight = {
        enable = true,
        -- 一部の言語ではvimの正規表現ハイライトシステムに依存
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
}
