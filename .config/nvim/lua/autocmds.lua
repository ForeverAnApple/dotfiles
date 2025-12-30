require "nvchad.autocmds"

-- Open nvim-tree on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("nvim-tree.api").tree.open()
    vim.cmd("wincmd p")  -- Focus back to the editing buffer
  end,
})
