local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local filtergc = loadstring(game:HttpGet(get_module("filtergc")))()

local function dummy_function()
    local Constant = "UniqueValue"
end

task.wait()

local result = filtergc("function", {
    Constants = { "UniqueValue" }
}, true)

print("Found function by constant:", result)