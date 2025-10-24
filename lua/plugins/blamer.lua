return {
  "APZelos/blamer.nvim",
  enabled = not vim.g.vscode,
  config = function()
    vim.g.blamer_enabled = true
    vim.g.blamer_date_format = "%Y/%m/%d"
  end,
}
