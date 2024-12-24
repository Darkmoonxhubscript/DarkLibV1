# DarkLib V1
**__This is a Test Library, After all, it's my first Library__**

## LoadString (IS REQUIRED)
```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()
```
```luau
--[[
Loads The Library
]]
```
## AddInfo
```luau
AddInfo({Title = "DarkMoonHub Library"})
```
```luau
--[[
Title ="DarkMoonHub Library" >> UI Title
]]
```
## Create Notification
```luau
NewNotify({
Title = "Notification Title",
Description = "Notification Description.",
Time = 10
})
```
```luau
--[[
Title = "Notification Title" >> Notification Title That Will Show
Description = "Notification Description." >> Notification Description That Will Show
Time = 10 >> Notification Duration
]]
```
## Create Tab
```luau
MakeTab({Name = "TabName"})
```
```luau
--[[
Name = "TabName" >> UI Button TabName
]]
```
## Add a Section
```luau
AddSection({
Tab = "Tab",
Text = "Text"
})
```
```luau
--[[
Tab = "Tab" >> Tab That Section Will Be Created
Text = "Text" >> Text Of Section
]]
```
## Add a Separator
```luau
AddSeparator({Tab = "Tab"})
```
```luau
--[[
Tab = "Tab" >> Tab That Will Create The Separator
]]
```
## Add a Button
```luau
AddButton({Tab = "MyTab", Text = "ButtonText",
Callback = function()
   
  end
})
```
```luau
--[[
Tab = "MyTab" >> Button Tab
Text = "ButtonText" >> Button Text
Callback = function(Value) -button press function
-- function here
end --end function
]]
```
