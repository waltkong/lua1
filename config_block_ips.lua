local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- 模式 0表示完全开放 1表示只禁用黑名单列表 2只放开白名单列表 3禁用黑名单&放开白名单
function _M.rull_mode()
    return 1
end 

function _M.block_ip_list()
    return {
        "192.168.88.210",
        "192.168.88.201",
    }
end

function _M.white_ip_list()
    return {
        "127.0.0.1"
    }
end

return _M

