package.path = package.path..";/home/kongweitao/luawww/testone/?.lua"

local block_logic = require("logic_block")
local db_logic = require("logic_db")

local logic_stream_control = require("logic_stream_control")
logic_stream_control.access_check()

block_logic.check_user_ip()
db_logic.insert_request_info()

ngx.say(" success 。。。")

