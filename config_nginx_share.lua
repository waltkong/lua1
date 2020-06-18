require "resty.core"

local _M = {

-- 所有可以共享的数据的名称
-- nginx配置 对应lua 脚本中 的ngx.shared.common_shared_data
-- lua_shared_dict common_shared_data 10m;
-- server{
-- }
    lua_shared_dict = ngx.shared.common_shared_data

}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end


return _M
