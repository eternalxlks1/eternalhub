local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Top Bar
local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(30,30,30)
Top.BorderSizePixel = 0
Top.Parent = Main

Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

-- Title
local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,1,0)
Title.Font = Enum.Font.GothamBold
Title.Text = "RIVALS"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 22
Title.Parent = Top

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,120,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(25,25,25)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-130,1,-50)
Content.Position = UDim2.new(0,125,0,45)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Layout
local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0,8)
UIList.Parent = Sidebar

-- Tabs
local tabs = {
    "Combat",
    "Visuals",
    "Movement",
    "Settings"
}

for _,name in ipairs(tabs) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-10,0,40)
    Button.Position = UDim2.new(0,5,0,0)
    Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Button.TextColor3 = Color3.fromRGB(255,255,255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.Text = name
    Button.Parent = Sidebar

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0,8)

    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(55,55,55)}
        ):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(35,35,35)}
        ):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        print(name .. " tab clicked")
    end)
end

-- Draggable
local dragging = false
local dragInput
local dragStart
local startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Top.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
