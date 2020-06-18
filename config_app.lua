local _M = {

    debug = true,

    database = {
        host = "192.168.88.208",
        port = 3306,
        database = "test1",
        user = "admin",
        password = "123456"
    },

    redis = {
        host = "127.0.0.1",
        port = 6379
    }

}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end


return _M
