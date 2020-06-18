local _M = {}


local redis_lib = require("resty.redis")
local config_app = require("config_app")
local config = config_app.redis
local util_log = require("util_log")

function _M.new (self)
    local red = redis_lib:new()
    red:set_timeouts(1000,1000,1000)  -- 1 sec
    local ok, err = red:connect(config["host"], config["port"])
    if not ok then
        util_log.error("<redis_error>fail to connect redis")
        ngx.say("fail to connect redis:",err)
        ngx.exit(500)
    end
    return red
end

return _M