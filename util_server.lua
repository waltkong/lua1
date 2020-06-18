local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

function _M.get_up_stream_ips()
    local upstream = require "ngx.upstream"
    local us = upstream.get_primary_peers('front')
    local ips = {}
    for _, u in ipairs(us) do
        table.insert(ips, u.name)
    end
    return ips
end

function _M.get_random_up_stream_ip()
    local ips = _M.get_up_stream_ips()
    local random = math.random(1, #ips)
    return ips[random]
end

return _M