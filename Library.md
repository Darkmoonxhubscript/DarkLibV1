# DarkLib V1
**__This is a Test Library, After all, it's my first Library__**

## LoadString
```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()
```
```luau
--[[
Loads The Library (It Must Be At The Beginning Of The Script,
 Mandatory)
]]
```
## AddInfo
```luau
AddInfo({
    Title = "DarkMoonHub Library"
})
```
```luau
--[[
Title ="DarkMoonHub Library" >> UI Title
]]
``|

## Create Tab
```luau
local TabName = MakeTab({Name = "TabName"})
```
```luau
--[[
local TabName >> TabName Variable
Name = "TabName" >> UI Button TabName
]]
```
## Add a Button
```luau
local Button = AddButton({
  Tab = "MyTab",
  Text = "ButtonText",
  Callback = function()
   --Button Action Here
  end
})
```
```luau
--[[
local Button >> Button Shortcut (It is not necessary to always put)
Tab = "MyTab" >> Button Tab
Text = "ButtonText" >> Button Text
Callback = function(Value) -button press function
-- function here
end --end function
]]
```
