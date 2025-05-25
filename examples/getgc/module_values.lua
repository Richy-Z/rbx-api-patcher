local get_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/andromeda-oss/rbx-api-patcher/main/module_helper.lua"))()
local getgc = loadstring(game:HttpGet(get_module("getgc")))()

getgenv().getgc = getgc

local mod = require(workspace:WaitForChild("MyModule"))

task.wait(0.05)

for _, value in pairs(getgc(true)) do
    if value == mod.my_func then
        print("✅ Found my_func from ModuleScript")
    elseif value == mod.my_table then
        print("✅ Found my_table from ModuleScript")
    end
end