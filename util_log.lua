local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

function _M.info(info)
    local config_app = require("config_app")
    local debug = config_app.debug
    if debug  then
        local date = os.date("%Y-%m-%d")
        local f = assert(io.open("/home/kongweitao/luawww/testone/log/info_".. date ..".log", "a"))
        local logs = "[" .. os.date("%Y-%m-%d %H:%M:%S") .. "]" .. info .. "\r\n"
        f:write(logs)
        f:close()
    end
end

function _M.error(info)
    local date = os.date("%Y-%m-%d")
    local f = assert(io.open("/home/kongweitao/luawww/testone/log/error_".. date ..".log", "a"))
    local logs = "[" .. os.date("%Y-%m-%d %H:%M:%S") .. "]" .. info .. "\r\n"
    f:write(logs)
    f:close()
end


return _M