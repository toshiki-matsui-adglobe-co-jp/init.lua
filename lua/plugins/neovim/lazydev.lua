return {
    -- Neovimの設定、ランタイム、プラグイン用のLua LSPを設定する 'lazydev' プラグイン
    -- Neovim APIの補完、注釈、シグネチャのために使用
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- 'vim.uv' という単語が見つかったときに 'luvit' の型情報をロード
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
}
