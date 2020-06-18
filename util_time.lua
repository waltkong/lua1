local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

function _M.get_now_time(is_timestamp)
    if is_timestamp == true then
        return os.time()
    else
        return os.date("%Y-%m-%d %H:%M:%S")
    end
end

return _M



