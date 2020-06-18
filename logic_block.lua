local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- 屏蔽ip黑名单的访问
function _M.check_user_ip()

    local config_block_ips = require("config_block_ips")
    local mode = config_block_ips.rull_mode()
    local is_block = _M.is_user_block()
    local is_white = _M.is_user_white()
    if mode == 0 then
        return 
    elseif mode == 1 then
        if is_block then 
            ngx.say("you are not allowed to visit")
            ngx.exit(403)
        end
    elseif mode == 2 then
        if not is_white then
            ngx.say("you are not allowed to visit")
            ngx.exit(403)
        end
    else 
        if is_block or not is_white then
            ngx.say("you are not allowed to visit")
            ngx.exit(403)
        end
    end

end


-- 判断该用户是否属于黑名单
function _M.is_user_block()

    -- 获取ip黑名单
    local config_block_ips = require("config_block_ips")
    local ips = config_block_ips.block_ip_list()

    local request_util = require("util_request")
    local user_ip = request_util.get_client_ip()

    local string_util = require("util_string")

    for k,v in pairs(ips) do
        if string_util.trim(tostring(v)) == string_util.trim(tostring(user_ip)) then
            return true
        end
    end
    return false

end

-- 判断该用户是否属于白名单
function _M.is_user_white()

    -- 获取ip白名单
    local config_block_ips = require("config_block_ips")
    local ips = config_block_ips.white_ip_list()

    local request_util = require("util_request")
    local user_ip = request_util.get_client_ip()

    local string_util = require("util_string")

    for k,v in pairs(ips) do
        if string_util.trim(tostring(v)) == string_util.trim(tostring(user_ip)) then
            return true
        end
    end
    return false

end


return _M
