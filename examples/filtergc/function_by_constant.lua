local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local filter_gc = loadstring(game:HttpGet(get_module("filtergc")))()

getgenv().filtergc = filter_gc

local function dummy_function()
    local Constant = "UniqueValue"
end

task.wait()

local result = filtergc("function", {
    Constants = { "UniqueValue" }
}, true)

print("Found function by constant:", result)