-- Order is important

-- 1st : setup
require("cange.globals")
Cange = require("cange.utils")
Cange.reload("cange.options")
-- 2st : plugins lazy loading
Cange.reload("cange.lazy")
-- 3th : rest
Cange.reload("cange.autocmds")
Cange.reload("cange.keymaps")
Cange.reload("cange.telescope")
