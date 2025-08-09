local lint = require("lint")

lint.linters_by_ft = Config.linters_by_ft

local try_lint = function() lint.try_lint(nil, { ignore_errors = true }) end

map("n", "<Leader>cl", try_lint, "Lint")

autocmd("Auto lint on save", augroup("LintOnSave"), { "BufWritePost" }, "*", try_lint)
