loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()

local Window = MakeWindow({Title = "DarkMoonHub Library"})

local Notify = NewNotify({
  Title = "Notification",
  Description = "Script Loaded!.",
  Time = 3
})

local Tab1 = NewTab({Name = "Universal"})
local Tab2 = NewTab({Name = "Game 1"})
local Tab3 = NewTab({Name = "Game 2"})

local Section1 = AddSection(Tab1, {Name = "Universal Tab"})

local TextLabel1 = AddTextLabel(Tab1, {
  Name = "My Text"
})

local Paragraph1 = AddParagraph(Tab1, {
  Name = "My Title",
  SubText = "My Paragraph"
})

local Button1 = AddButton(Tab1, {
  Name = "Reset Humanoid",
  Callback = function()
  game.Players.LocalPlayer.Character.Humanoid.Health = 0
  end
})

local Toggle1 = AddToggle(Tab1, {
  Name = "AutoFarm",
  Default = false,
  Callback = function(Value)
  print(Value)
  end
})

local TextBox1 = AddTextBox(Tab1, {
  Name = "Dark TextBox",
  Default = "Muito Bom Dia",
  AutoClear = false,
  PlaceHolder = "Input Here",
  Callback = function(Value)
    print(Value)
    end
})

local Slider1 = AddSlider(Tab1, {
  Name = "Slider Test",
  Min = 1,
  Max = 100,
  Increase = 1,
  Default = 20,
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
