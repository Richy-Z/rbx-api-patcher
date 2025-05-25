local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local get_gc = loadstring(game:HttpGet(get_module("getgc")))()

getgenv().getgc = get_gc

local dummy_table = {}
local function dummy_function() end

task.wait(0.05)

for _, value in pairs(getgc(true)) do
    if value == dummy_function then
        print("✅ Found dummy function (local)")
    elseif value == dummy_table then
        print("✅ Found dummy table (local)")
    end
end