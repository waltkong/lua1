local _M = {}

local mt = { __index = _M }

function _M.new (self)
    return setmetatable({}, mt)
end

-- 请求参数信息入库
function _M.insert_request_info()
    local mysql = require("util_db")
    local db = mysql:new()
    local util_log = require("util_log")
    
    local request_util = require("util_request") 
    local time_util = require("util_time")  

    local insert_data_table = {
        client_ip = request_util.get_client_ip(),
        server_ip = request_util.get_server_ip(),
        uri = request_util.get_request_uri(),
        user_agent = request_util.get_user_agent(),
        cookie = request_util.get_cookie(),
        created_at = time_util.get_now_time(false)
    }

    local insert_data_string = "'" ..insert_data_table["client_ip"] .. "'," ..
    "'" ..insert_data_table["server_ip"] .. "'," ..
    "'" ..insert_data_table["uri"] .. "'," ..
    "'" ..insert_data_table["user_agent"] .. "'," ..
    "'" ..insert_data_table["cookie"] .. "'," ..
    "'" ..insert_data_table["created_at"] .. "'"

    local sql = "insert into request_log (client_ip,server_ip,uri,user_agent,cookie,created_at) values (" .. insert_data_string .. ")"
    util_log.info("sql:" .. sql)

    local insert_result, err, errno, sqlstate = db:query(sql) 

    if not insert_result then
        util_log.error("<sql_error>error_no:" .. tostring(errno))
    end

    -- 操作完关闭数据连接
    db:close()

end

return _M


