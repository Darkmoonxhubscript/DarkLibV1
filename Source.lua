-- Funções iniciais
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

-- Criação da Interface
local ScreenGui = Create("ScreenGui", CoreGui, {
    ResetOnSpawn = false
})

-- Fundo principal (Interface central)
local MainFrame = Create("Frame", ScreenGui, {
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

-- Título
Create("TextLabel", TopBar, {
    Name = "Title",
    Text = "DarkLib",
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.Cartoon,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
    Size = UDim2.new(0.3, 0, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1
})

-- Botão "X" para fechar
local CloseButton = Create("TextButton", TopBar, {
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
    Name = "LeftBar",
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    Size = UDim2.new(0.2, 0, 0.9, 0),
    Position = UDim2.new(0, 0, 0.1, 0)
})
Corner(LeftBar, UDim.new(0.05, 0))

local LeftScrollFrame = Create("ScrollingFrame", LeftBar, {
    Name = "LeftScrollFrame",
    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
})
Create("UIListLayout", LeftScrollFrame)

-- RightFrame para Tabs
local RightScrollFrame = Create("Frame", MainFrame, {
    Name = "RightScrollFrame",
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderSizePixel = 0,
    Size = UDim2.new(0.8, 0, 0.9, 0),
    Position = UDim2.new(0.2, 0, 0.1, 0)
})
Corner(RightScrollFrame)

local Tabs = {}
local SelectedTab = ""  -- Agora é uma string representando o nome da aba selecionada
local FirstTab = nil  -- Variável para armazenar o nome da primeira tab

function MakeTab(Config)
    local TabName = Config.Name or "Tab"
    local TabButton
    local TabFrame

    -- Se for a primeira tab, armazena o nome e marca como selecionada
    if not FirstTab then
        FirstTab = TabName
        SelectedTab = TabName  -- Atualiza SelectedTab com o nome da primeira aba
    end

    -- Ajustar a posição X para alinhar com LeftBar
    TabButton = Create("TextButton", LeftScrollFrame, {
        Text = TabName,
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.Cartoon,
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        Size = UDim2.new(1, -10, 0, 30),
        TextWrapped = false,
        ClipsDescendants = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = "AtEnd",
        Position = UDim2.new(0, 0, 0, 0)  -- Ajustado para alinhar
    })
    Corner(TabButton, UDim.new(0.1, 0))  -- Cantos arredondados

    TabFrame = Create("ScrollingFrame", RightScrollFrame, {
        Name = TabName,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = false,  -- Inicialmente invisível
        CanvasSize = UDim2.new(0, 0, 0, 10),
        ScrollBarThickness = 5,
        AutomaticCanvasSize = Enum.AutomaticSize.Y
    })

    Create("UIListLayout", TabFrame, {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Tabs[TabName] = TabFrame

    -- Se for a primeira tab, faz ela visível
    if SelectedTab == TabName then
        TabFrame.Visible = true
    end

    TabButton.MouseButton1Click:Connect(function()
        -- Esconde todas as tabs
        for _, frame in pairs(Tabs) do
            frame.Visible = false
        end
        -- Mostra a tab clicada
        TabFrame.Visible = true
        SelectedTab = TabName  -- Atualiza SelectedTab para a aba selecionada
    end)

    return TabFrame
end

return DarkLib
