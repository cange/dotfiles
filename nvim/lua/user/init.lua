-- Order is important

-- 1st : setup
require("user.globals")
User = require("user.utils")
Icon = require("user.icons")
require("user.options")
-- 2st : plugins lazy loading
require("user.lazy")
-- 3th : rest
require("user.autocmds")
require("user.keymaps")
