loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()

AddInfo({
    Title = "DarkMoonHub Library"
})

local Tab1 = MakeTab({Name = "Tab1"})
local Tab2 = MakeTab({Name = "Tab2"})

local Button1 = AddButton({
  Tab = "Tab1",
  Text = "My Button For Tab 1! ",
  Callback = function()
   print("Clicked!")
  end
})

AddButton({
  Tab = "Tab2",
  Text = "My Button For Tab 2, 1.",
  Callback = function()
   print("Clicked!")
  end
})

AddButton({
  Tab = "Tab2",
  Text = "My Button For Tab 2, 2.",
  Callback = function()
   print("Clicked!")
  end
})
