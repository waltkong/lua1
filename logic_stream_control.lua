local _M = {}

local mt = { __index = _M }

require "resty.core"

local config_nginx_share = require("config_nginx_share")
local lua_shared_dict =  config_nginx_share.lua_shared_dict

-- 该秒数内的流量控制
local in_seconds = 10
-- 个人最大次数限制
local each_user_limit = 2
-- 所有人最大次数限制
local total_user_limit = 1000

-- 总访问量
local total_user_key = "stream_control_total_user_visit_count"
-- 个人访问量
local each_user_key_prefix = "stream_control_each_user_"

function _M.new (self)
    return setmetatable({}, mt)
end

-- 访问检查
function _M.access_check()
    local util_string = require("util_string")
    local util_log = require("util_log")
    local util_request = require("util_request")

    -- 个人访问控制逻辑
    local each_user_key = tostring(each_user_key_prefix .. util_request.get_client_ip())
    local each_user_count , _ = lua_shared_dict:get(each_user_key)
    if each_user_count then 
        if each_user_count >= each_user_limit then
            ngx.say("you are requesting too many times , please visit later")
            ngx.exit(403)
        else 
            if each_user_count > 0 then
                lua_shared_dict:incr(each_user_key,1)
            else 
                lua_shared_dict:set(each_user_key,1,in_seconds)
            end
        end
    else 
        lua_shared_dict:set(each_user_key,1,in_seconds)
    end

    -- 所有人访问控制逻辑
    local total_user_count , _ = lua_shared_dict:get(total_user_key)
    if total_user_count then 
        if total_user_count >= total_user_limit then
            ngx.say("the server is reaching its flow restriction , please visit later")
            ngx.exit(403)
        else 
            if total_user_count > 0 then
                lua_shared_dict:incr(total_user_key,1)
            else 
                lua_shared_dict:set(total_user_key,1,in_seconds)
            end
        end
    else 
        lua_shared_dict:set(total_user_key,1,in_seconds)
    end

end

return _M