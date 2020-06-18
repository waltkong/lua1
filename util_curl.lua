local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- LUA 调用外部接口
-- args 为 table类型
function _M.getHttp(url,args)
    local response = ngx.location.capture(url,{
        method = ngx.HTTP_GET,
        args = args
    })
    if response then 
        local ret = cjson.decode(response.body)
        return ret
    else 
        local util_log = require("util_log")
        util_log.error("<api_error>" .. "request this url error:" .. url)
        return nil
    end
end


-- LUA 调用外部接口
-- args 为 table类型
function _M.postHttp(url,args)
    local response = ngx.location.capture(url,{
        method = ngx.HTTP_POST,
        args = args
    })
    if response then 
        local ret = cjson.decode(response.body)
        return ret
    else 
        local util_log = require("util_log")
        util_log.error("<api_error>" .. "request this url error:" .. url)
        return nil
    end
end



return _M