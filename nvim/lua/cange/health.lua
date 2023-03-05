local M = {}

function M.check()
  vim.health.report_start("Cange")

  for _, cmd in ipairs({ "git", "rg", "deno" }) do
    if vim.fn.executable(cmd) == 1 then
      vim.health.report_ok(("`%s` is installed"):format(cmd))
    else
      vim.health.report_warn(("`%s` is not installed"):format(cmd))
    end
  end
end

return M
