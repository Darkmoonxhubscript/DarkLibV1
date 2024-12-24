loadstring(game:HttpGet("https://raw.githubusercontent.com/Darkmoonxhubscript/DarkLibV1/refs/heads/main/Source.luau"))()

AddInfo({Title = "Example Script"})

NewNotify({
Title = "Notification",
Description = "Script Loaded!.",
Time = 5
})

MakeTab({Name = "Tab1"})
MakeTab({Name = "Tab2"})
MakeTab({Name = "Tab3"})
MakeTab({Name = "Tab4"})
MakeTab({Name = "Tab5"})

AddSection({
Tab = "Tab1",
Text = "Section 1"
})
AddSection({
Tab = "Tab2",
Text = "Section 2"
})
AddSection({
Tab = "Tab3",
Text = "Section 3"
})
AddSection({
Tab = "Tab4",
Text = "Section 4"
})
AddSection({
Tab = "Tab5",
Text = "Section 5"
})

AddSeparator({Tab = "Tab1"})
AddSeparator({Tab = "Tab2"})
AddSeparator({Tab = "Tab3"})
AddSeparator({Tab = "Tab4"})
AddSeparator({Tab = "Tab5"})

AddButton({Tab = "Tab1", Text = "Button 1",
Callback = function()
   print("Tab 1 Button")
NewNotify({
Title = "Notification",
Description = "Working!.",
Time = 1
})
  end
})
AddButton({Tab = "Tab2", Text = "Button 2",
Callback = function()
   print("Tab 2 Button")
NewNotify({
Title = "Notification",
Description = "Working!.",
Time = 1
})
  end
})
AddButton({Tab = "Tab3", Text = "Button 3",
Callback = function()
   print("Tab 3 Button")
NewNotify({
Title = "Notification",
Description = "Working!.",
Time = 1
})
  end
})
AddButton({Tab = "Tab4", Text = "Button 4",
Callback = function()
   print("Tab 4 Button")
NewNotify({
Title = "Notification",
Description = "Working!.",
Time = 1
})
  end
})
AddButton({Tab = "Tab5", Text = "Button 5",
Callback = function()
   print("Tab 5 Button")
NewNotify({
Title = "Notification",
Description = "Working!.",
Time = 1
})
  end
})
