local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Tabs = {}

local function SetProps(Instance, Props)
    if Props then
        for prop, value in pairs(Props) do
            Instance[prop] = value
        end
    end
    return Instance
end

local function Create(...)
    local args = {...}
    local new = Instance.new(args[1])
    local parent = args[2]
    local props = args[3]
    
    if parent then
        new.Parent = parent
    end
    if props then
        SetProps(new, props)
    end
    return new
end

local function Corner(parent, radius)
    return Create("UICorner", parent, {
        CornerRadius = radius or UDim.new(0, 5)
    })
end

local function Stroke(parent, Colorstk, Thickness)
    local new = Create("UIStroke", parent, {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Colorstk or Color3.fromRGB(120, 120, 120),
        Thickness = Thickness or 0.1
    })
    return new
end


local function MakeDrag(Instance)
    local Dragging, DragInput, DragStart, StartPosition

    local function Update(input)
        local Delta = input.Position - DragStart
        Instance.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end

    Instance.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = Instance.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    Instance.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

local function CreateTween(Configs)
  local Instance = Configs[1] or Configs.Instance
  local Prop = Configs[2] or Configs.Prop
  local NewVal = Configs[3] or Configs.NewVal
  local Time = Configs[4] or Configs.Time or 0.5
  local TweenWait = Configs[5] or Configs.wait or false
  local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Quint)
  
  local Tween = TweenService:Create(Instance, TweenInfo, {[Prop] = NewVal})
  Tween:Play()
  if TweenWait then
    Tween.Completed:Wait()
  end
  return Tween
end

function MakeWindow(WindowConfig)
local Title = WindowConfig[1] or WindowConfig.Title or "DarkLib V1"
  
local ScreenGui = Create("ScreenGui", CoreGui, {
    Name = "DarkLibraryV1",
    ResetOnSpawn = false
})


-- Notification

local NotifyMenu = Create("Frame", ScreenGui, {
    Size = UDim2.new(0, 300, 1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1
})

Create("UIPadding", NotifyMenu, {
    PaddingLeft = UDim.new(0, 25),
    PaddingTop = UDim.new(0, 25),
    PaddingBottom = UDim.new(0, 50)
})

Create("UIListLayout", NotifyMenu, {
    Padding = UDim.new(0, 15),
    VerticalAlignment = Enum.VerticalAlignment.Bottom
})

function NewNotify(Config)
    local Title = Config.Title or "Notification"
    local Description = Config.Description or "Description"
    local Time = Config.Time or 5

    local Frame1 = Create("Frame", NotifyMenu, {
        Size = UDim2.new(1, 0, 0, 75),
        BackgroundTransparency = 1
    })

    local Frame2 = Create("Frame", Frame1, {
        Size = UDim2.new(1, -50, 0, 75),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Stroke(Frame2, Color3.fromRGB(120, 120, 120), 3)
    Corner(Frame2)

    Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -30, 0, 25),
        Font = Enum.Font.FredokaOne,
        BackgroundTransparency = 1,
        Text = Title,
        TextSize = 20,
        Position = UDim2.new(0, 10, 0, 5),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })

    local CloseButton = Create("TextButton", Frame2, {
        Text = "X",
        Font = Enum.Font.FredokaOne,
        TextSize = 20,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        Position = UDim2.new(1, -5, 0, 5),
        AnchorPoint = Vector2.new(1, 0),
        Size = UDim2.new(0, 25, 0, 25)
    })

    CloseButton.MouseButton1Click:Connect(function()
        Frame1:Destroy()
    end)

    Create("TextLabel", Frame2, {
        Size = UDim2.new(1, -30, 0, 0),
        Position = UDim2.new(0, 10, 0, 35),
        TextSize = 15,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextXAlignment = Enum.TextXAlignment.Left,
        Text = Description,
        Font = Enum.Font.FredokaOne,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true
    })

    -- Separator
    local Separator = Create("Frame", Frame2, {
        Size = UDim2.new(1, -4, 0, 2),
        BackgroundColor3 = Color3.fromRGB(55, 55, 55),
        Position = UDim2.new(0, 2, 1, -4)
    })
    Stroke(Separator, Color3.fromRGB(255, 255, 255), 0.1)
    
    Corner(Frame2, UDim.new(0, 0))
task.spawn(function()
    task.wait(Time)
    Frame1:Destroy()
    end)
end


local MainFrame = Create("Frame", ScreenGui, {
    Name = "MainFrame",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Size = UDim2.new(0.5, 0, 0.6, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true,
    BackgroundTransparency = 1
})
Corner(MainFrame, UDim.new(0.05, 0))
MakeDrag(MainFrame)

local FakeMainFrame = Create("Frame", MainFrame, {
    Name = "MainFrameFake",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Size = UDim2.new(0.5, 0, 0.6, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true
})
Corner(MainFrame, UDim.new(0.05, 0))

-- TopBar
local TopBar = Create("Frame", MainFrame, {
    Name = "TopBar",
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    Size = UDim2.new(1, 0, 0.1, 0),
    Position = UDim2.new(0, 0, 0, 0)
})
Corner(TopBar, UDim.new(0.2, 0))

-- Title
Create("TextLabel", TopBar, {
    Name = "Title",
    Text = Title,
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.FredokaOne,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(0.8, 0, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    TextWrapped = false,
    BackgroundTransparency = 1
})

-- Close
local CloseButton = Create("TextButton", TopBar, {
    Name = "Close",
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.FredokaOne,
    TextSize = 20,
    BackgroundTransparency = 1,
    Size = UDim2.new(0.1, 0, 1, 0),
    Position = UDim2.new(1, -50, 0, 0)
})
CloseButton.MouseButton1Click:Connect(function()
  local tween = TweenService:Create(MainFrame, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 0)})
  tween:Play()
  tween.Completed:Wait()
  ScreenGui:Destroy()
end)

-- LeftBar
local LeftBar = Create("Frame", MainFrame, {
    Name = "TabsBar",
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    Size = UDim2.new(0.2, 0, 0.9, 0),
    Position = UDim2.new(0, 0, 0.1, 0)
})
Corner(LeftBar, UDim.new(0.05, 0))

local LeftScrollFrame = Create("ScrollingFrame", LeftBar, {
    Name = "TabsScrollFrame",
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ScrollBarThickness = 0,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
    ElasticBehavior = Enum.ElasticBehavior.Never
})
Create("UIListLayout", LeftScrollFrame, {
  Padding = UDim.new(0, 8),
})

-- RightFrame
local RightScrollFrame = Create("Frame", MainFrame, {
    Name = "Containers",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    Size = UDim2.new(0.8, 0, 0.9, 0),
    Position = UDim2.new(0.2, 0, 0.1, 0)
})
Corner(RightScrollFrame)

local Padding = Create("UIPadding", RightScrollFrame, {
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
        PaddingTop = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 5)
    })


local SelectedTab = "" 
local FirstTab = nil 

function NewTab(Config)
    local TabName = Config.Name or "Tab"
    local TabButton
    local TabFrame

    
    if not FirstTab then
        FirstTab = TabName
        SelectedTab = TabName  
    end

    
    TabButton = Create("TextButton", LeftScrollFrame, {
        Name = "TabButton",
        Text = TabName,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.FredokaOne,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(1, -10, 0, 30),
        TextWrapped = false,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = "AtEnd",
        AutomaticSize = Enum.AutomaticSize.X,
        Position = UDim2.new(0, 0, 0, 0)  
    })
    --Stroke(TabButton, Color3.fromRGB(200, 200, 200))
    --Corner(TabButton, UDim.new(0.3, 0))  

    TabFrame = Create("ScrollingFrame", RightScrollFrame, {
        Name = TabName,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,  
        ScrollBarThickness = 0,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new()
    })

    Create("UIListLayout", TabFrame, {
        Padding = UDim.new(0, 7),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Tabs[TabName] = TabFrame

    
    if SelectedTab == TabName then
        TabFrame.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, button in pairs(LeftScrollFrame:GetChildren()) do
            if button:IsA("TextButton") then
                button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        
        TabButton.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        for _, frame in pairs(Tabs) do
            frame.Visible = false
        end
        
        TabFrame.Visible = true
        SelectedTab = TabName 
    end)

    return TabFrame
end

function AddButton(Parent, Config)
    local Name = Config[1] or Config.Name or "Button"
    local Callback = Config.Callback or function() print("Clicked") end
    
    local Button = Create("TextButton", Parent, {
        Text = "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.FredokaOne,
        TextSize = 20,
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(0, 490, 0, 40),
        TextWrapped = false,
        Position = UDim2.new(0, 10, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
    Stroke(Button, Color3.fromRGB(120, 120, 120), 1)
    Corner(Button, UDim.new(0.1, 0)) 

    local TextLabel = Create("TextLabel", Button, {
      Text = Name,
      TextColor3 = Color3.fromRGB(240, 240, 240),
      Font = Enum.Font.FredokaOne,
      TextSize = 20,
      Size = UDim2.new(0, 200, 0, 40),
      TextWrapped = false,
      BackgroundTransparency = 1,
      Position = UDim2.new(0, 10, 0, 0),
      TextXAlignment = Enum.TextXAlignment.Left,
      TextYAlignment = Enum.TextYAlignment.Center
    })

    local Image = Create("ImageLabel", Button, {
        Image = "rbxassetid://14815405190",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 5),
        BackgroundTransparency = 1
    })

    Button.MouseButton1Click:Connect(function()
        Callback()
    end)

    return Button
end

function AddSection(Parent, Config)
    local Name = Config[1] or Config.Name or "Section"
    
    local SectionFrame = Create("Frame", Parent, {
        Size = UDim2.new(0, 490, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BackgroundTransparency = 0
    })
    Stroke(SectionFrame, Color3.fromRGB(120, 120, 120), 1)
    Corner(SectionFrame)

    local SectionLabel = Create("TextLabel", SectionFrame, {
        Size = UDim2.new(0, 200, 0, 40),
        Position = UDim2.new(0, 10, 0, 0),
        Text = Name,
        Font = Enum.Font.FredokaOne,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 20,
        BackgroundTransparency = 1,
        TextWrapped = false,
        TextTruncate = "AtEnd",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    return SectionFrame
end

function AddToggle(Parent, Config)
    local Name = Config[1] or Config.Name or "Toggle"
    local Default = Config[2] or Config.Default or false
    local Callback = Config.Callback or function() end

    local ToggleFrame1 = Create("Frame", Parent, {
        Size = UDim2.new(0, 490, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BackgroundTransparency = 0
    })
    Stroke(ToggleFrame1, Color3.fromRGB(120, 120, 120), 1)
    Corner(ToggleFrame1)

    local ToggleFrame2 = Create("Frame", ToggleFrame1, {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 5),
        BackgroundTransparency = 1
    })
    Stroke(ToggleFrame2, Color3.fromRGB(120, 120, 120), 1)
    Corner(ToggleFrame2)

    local ToggleActive = Create("Frame", ToggleFrame1, {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 5),
        BackgroundColor3 = Color3.fromRGB(160, 160, 160),
        Visible = false
    })
    Stroke(ToggleActive, Color3.fromRGB(160, 160, 160), 1)
    Corner(ToggleActive)

    local ToggleState = false
    if Default then
        SetProps(ToggleActive, {
            Visible = true
        })
        ToggleState = true
    end

    Callback(ToggleState)

    local TextToggle = Create("TextLabel", ToggleFrame1, {
        Text = Name,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.FredokaOne,
        TextSize = 20,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 0, 40),
        Position = UDim2.new(0, 10, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })

    local ToggleButtonArea = Create("TextButton", ToggleFrame1, {
        Text = "",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0, 5),
        BackgroundTransparency = 1
    })

    ToggleButtonArea.MouseButton1Click:Connect(function()
        if ToggleState then
          local tween = TweenService:Create(ToggleActive, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new()})
          tween:Play()
          tween.Completed:Wait()
            SetProps(ToggleActive, {
                Visible = false
            })
            ToggleState = false
        elseif not ToggleState then
          SetProps(ToggleActive, {
                Visible = true
            })
          local tween = TweenService:Create(ToggleActive, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 30, 0, 30)})
          tween:Play()
          tween.Completed:Wait()
            ToggleState = true
        end
        Callback(ToggleState)
    end)

    return {ToggleActive, Callback, ToggleState}
end

function AddTextBox(Parent, Config)
  local Name = Config[1] or Config.Name or "TextBox"
  local Default = Config[2] or Config.Default or ""
  local AutoClear = Config[3] or Config.AutoClear or false
  local PlaceHolder = Config[4] or Config.PlaceHolder or "Input Here"
  local Callback = Config[5] or Config.Callback or function() end
  
  local TextBoxFrame = Create("Frame", Parent, {
        Size = UDim2.new(0, 490, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        BackgroundTransparency = 0
    })
    Stroke(TextBoxFrame, Color3.fromRGB(120, 120, 120), 1)
    Corner(TextBoxFrame)
     
     local TextBoxText = Create("TextLabel", TextBoxFrame, {
        Text = Name,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        Font = Enum.Font.FredokaOne,
        TextSize = 20,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 0, 40),
        Position = UDim2.new(0, 10, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    })
  
  local TextBox = Create("TextBox", TextBoxFrame, {
    Size = UDim2.new(0, 80, 1, -10),
    Position = UDim2.new(1, -90, 0, 5),
    ClearTextOnFocus = false,
    BackgroundTransparency = 1,
    Text = Default,
    TextColor3 = Color3.fromRGB(240, 240, 240),
    Font = Enum.Font.FredokaOne,
    PlaceholderText = PlaceHolder,
    TextScaled = true
  })
  Stroke(TextBox, Color3.fromRGB(120, 120, 120), 1)
  Corner(TextBox)
  
  Callback(Default)
  TextBox.FocusLost:Connect(function()
    Callback(TextBox.Text)
    if AutoClear == true then
    TextBox.Text = ""
    end
  end)
     return TextBoxFrame
  end

end


return DarkLib
