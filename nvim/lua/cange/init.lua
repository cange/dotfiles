-- Order is important

-- 1st : setup
require("cange.globals")
Cange = require("cange.utils")
require("cange.options")
-- 2st : plugins lazy loading
require("cange.lazy")
-- 3th : rest
require("cange.autocmds")
require("cange.keymaps")
