local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local filtergc = loadstring(game:HttpGet(get_module("filtergc")))()

local dummy_table = {
    SecretKey = true,
    Owner = "Player123"
}

task.wait()

local result = filtergc("table", {
    Keys = { "SecretKey", "Owner" }
}, true)

print("Found table by keys:", result and result.Owner)