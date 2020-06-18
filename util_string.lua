local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- 忽略字符串首尾的空白字符
function _M.trim(input)
    return (string.gsub(input, "^%s*(.-)%s*$", "%1"))
end

-- 判断是否为空
function _M.is_empty(input)
    if input == nil or input == "" or input == 0 then
        return true
    else
        return false
    end
end


return _M

