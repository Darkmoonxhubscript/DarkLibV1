loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()

local Window = MakeWindow({Title = "DarkMoonHub Library"})

AddMinimizeButton({
  ImageId = "10734897102"
})

local Notify = NewNotify({
  Title = "Notification",
  Description = "Script Loaded!.",
  Time = 3
})

local Tab1 = NewTab({Name = "Universal"})
local Tab2 = NewTab({Name = "Game 1"})
local Tab3 = NewTab({Name = "Game 2"})

local Section1 = AddSection(Tab1, {Name = "Universal Tab"})

local ServerInvite = AddDiscordInvite(Tab1, {
  Name = "DarkMoonHub Community",
  Description = "Join our discord community to receive information about the next update",
  Logo = "rbxassetid://10734897102",
  Invite = "https://discord.gg/YDXM43cBU6",
})

local TextLabel1 = AddTextLabel(Tab1, {
  Name = "My Text"
})

local Paragraph1 = AddParagraph(Tab1, {
  Name = "My Title",
  SubText = "My Paragraph"
})

local Button1 = AddButton(Tab1, {
  Name = "Button",
  Callback = function()
    AddFloatToggle({
    Name = "Toggle Name",
    Callback = function(Value)
      
      end
  })
print("Oii")
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
  Min = 0,
  Max = 1000,
  Increase = 1,
  Default = 50,
  Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local Dropdown1 = AddDropDown(Tab1, {
  Name = "Dropdown Test",
  Options = {"1", "2", "3", "4", "5", "6", "7"},
  Default = "Ola",
  Callback = function(Value)
    print(Value)
    end
})
