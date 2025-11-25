-- テキストをヤンク（コピー）したときにハイライト表示
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "テキストをヤンクしたときにハイライト表示",
  group = vim.api.nvim_create_augroup("highlight_yank", {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
