local M = {}

local start = vim.loop.hrtime()

-- calculate startup time once Neovim finishes loading
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    M.time = (vim.loop.hrtime() - start) / 1e6
  end,
})

function M.get()
  return M.time or 0
end

function M.format()
  return string.format("  Startup time: %.2f ms", M.get())
end

return M
