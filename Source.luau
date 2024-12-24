local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

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

local ScreenGui = Create("ScreenGui", CoreGui, {
    Name = "DarkLibraryV1",
    ResetOnSpawn = false
})

local MainFrame = Create("Frame", ScreenGui, {
    Name = "MainFrame",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Size = UDim2.new(0.5, 0, 0.6, 0),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Active = true
})
Corner(MainFrame, UDim.new(0.05, 0))
MakeDrag(MainFrame)

-- TopBar
local TopBar = Create("Frame", MainFrame, {
    Name = "TopBar",
    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
    Size = UDim2.new(1, 0, 0.1, 0),
    Position = UDim2.new(0, 0, 0, 0)
})
Corner(TopBar, UDim.new(0.2, 0))

function AddInfo(Config)
    local Title = Config.Title or "DarkMoonHub Library"
    
    local TitleLabel = TopBar:FindFirstChild("Title")
    if TitleLabel then
        TitleLabel.Text = Title
    end
end

-- Title
Create("TextLabel", TopBar, {
    Name = "Title",
    Text = "DarkLib",
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.Cartoon,
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
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.Cartoon,
    TextSize = 20,
    BackgroundTransparency = 1,
    Size = UDim2.new(0.1, 0, 1, 0),
    Position = UDim2.new(1, -50, 0, 0)
})
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- LeftBar
local LeftBar = Create("Frame", MainFrame, {
    Name = "TabBar",
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
    ElasticBehavior = Enum.ElasticBehavior.Never
})
Create("UIListLayout", LeftScrollFrame, {
  Padding = UDim.new(0, 5),
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
        PaddingLeft = UDim.new(0, 5),
        PaddingRight = UDim.new(0, 5),
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5)
    })

local Tabs = {}
local SelectedTab = "" 
local FirstTab = nil 

function MakeTab(Config)
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
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.Cartoon,
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
    Corner(TabButton, UDim.new(0.3, 0))  

    TabFrame = Create("ScrollingFrame", RightScrollFrame, {
        Name = TabName,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,  
        ScrollBarThickness = 0,
        ElasticBehavior = Enum.ElasticBehavior.Never,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })

    Create("UIListLayout", TabFrame, {
        Padding = UDim.new(0, 7),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Tabs[TabName] = TabFrame

    
    if SelectedTab == TabName then
        TabFrame.Visible = true
        TabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    end

    TabButton.MouseButton1Click:Connect(function()
        for _, button in pairs(LeftScrollFrame:GetChildren()) do
            if button:IsA("TextButton") then
                button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        
        TabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        for _, frame in pairs(Tabs) do
            frame.Visible = false
        end
        
        TabFrame.Visible = true
        SelectedTab = TabName 
    end)

    return TabFrame
end

function AddButton(Config)
    local Tab = Config.Tab
    local Text = Config.Text or "Button"
    local Callback = Config.Callback or function() end
    
    local Button = Create("TextButton", Tabs[Tab], {
        Text = Text,
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.Cartoon,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true
    })
    Corner(Button, UDim.new(0.1, 0)) 

    local Image = Create("ImageLabel", Button, {
        Image = "rbxassetid://12795925899",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -30, 0, 10),
        BackgroundTransparency = 1
    })

    Button.MouseButton1Click:Connect(function()
        Callback()
    end)

    return Button
end



return DarkLib
