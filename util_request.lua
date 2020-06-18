local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- 获取客户端ip
function _M.get_client_ip()
    local headers = ngx.req.get_headers()
    local ip=headers["X-REAL-IP"] or headers["X_FORWARDED_FOR"] or ngx.var.remote_addr or "0.0.0.0"
    return ip
end

--获取服务端ip
function _M.get_server_ip()
    local socket = require("socket")
    local ip,resolved = socket.dns.toip(socket.dns.gethostname());
    return ip
end

-- 获取请求地址
function _M.get_request_uri()
    --获取客户端请求参数的原始URI
    local request_uri = ngx.var.request_uri
    -- 请求中的当前URI
    local uri = ngx.var.uri 
    return uri
end

--获取user-agent
function _M.get_user_agent()
    local headers = ngx.req.get_headers()
    local user_agent = headers["user_agent"] or ""
    local util_string = require("util_string")
    if(util_string.is_empty(user_agent)) then
        return ""
    end
    return user_agent
end

--获取cookie
function _M.get_cookie()
    local cookie = ngx.var.http_cookie
    local util_string = require("util_string")
    if(util_string.is_empty(cookie)) then
        return ""
    end
    return cookie
end

--get请求参数
function _M.get_args()
    local arg = ngx.req.get_uri_args()
    for k,v in pairs(arg) do

    end
    --[另一种方式]拿到uri中的参数
    -- local kk = ngx.var.arg_kk
    -- local tt = ngx.var.arg_tt
    return arg
end

--post请求参数
function _M.post_args()
    ngx.req.read_body()
    local arg = ngx.req.get_post_args()
    for k,v in pairs(arg) do

    end
    return arg
end  

return _M








