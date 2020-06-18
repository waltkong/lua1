local _M = {}

local mysql = require("resty.mysql")
local config_app = require("config_app")
local config = config_app.database

function _M.new(self)
    local db, err = mysql:new()
    local util_log = require("util_log")
    if not db then
        util_log.error("<mysql_error>db init err")
        ngx.say("fail to init mysql:",err)
        ngx.exit(500)
    end
    db:set_timeout(1000) -- 1 sec
    local ok, err, errno, sqlstate = db:connect(config)
    if not ok then
        util_log.error("<mysql_error>db connect err")
        ngx.say("fail to connect mysql:",err)
        ngx.exit(500)
    end
    return db
end

return _M

