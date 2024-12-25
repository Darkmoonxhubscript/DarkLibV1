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
local Window = MakeWindow({Title = "DarkMoonHub Library"})
```
```luau
--[[
Title ="DarkMoonHub Library" >> UI Title
]]
```
## Create Notification
```luau
local Notify = NewNotify({
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
local Tab1 = NewTab({Name = "Tab"})
```
```luau
--[[
Name = "TabName" >> UI Button TabName
]]
```
## Add a Section
```luau
local Section1 = AddSection(Tab1, {Name = "Section"})
```
```luau
--[[
Name = "Text" >> Text Of Section
]]
```
## Add a Button
```luau
local Button1 = AddButton(Tab1, {
  Name = "Button",
  Callback = function()
  
  end
})

```
```luau
--[[
Name = "Text" >> Button Text
Callback = function(Value) -button press function
-- function here
end --end function
]]
```
## Add a Toggle
```luau
local Toggle1 = AddToggle(Tab1, {
  Name = "Toggle",
  Default = false,
  Callback = function(Value)
  print(Value)
  end
})
```
```luau
--[[
Name = "Toggle" >> Toggle Text
Default = false >> Defines whether the toggle starts out on or off
Callback = function(Value) --Value = toggle state
-- toggle function here
end
]]
```
## Add a TextBox
```luau
local TextBox1 = AddTextBox(Tab1, {
  Name = "TextBox",
  Default = "Default Text",
  AutoClear = false,
  PlaceHolder = "Input Text Here",
  Callback = function(Value)
    print(Value)
    end
})
```
```luau
--[[
Name = "TextBox" >> TextBox Name
Default = "Default Text" >> TextBox Default Text
AutoClear = false >> Auto Clear Text When Input
PlaceHolder = "Input Text Here" >> PlaceHolder Text From TextBox
Callback = function(Value) --Value = TextBox Text
--Functiom Here
end
]]
```
