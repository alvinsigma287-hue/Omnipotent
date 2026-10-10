-- Target-Specific Ultra Collector (LowCoritsol / WEGA) - Final Loadable Build
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

print("Loading LowCoritsol Collector Script...")

if LocalPlayer.PlayerGui:FindFirstChild("LowCoritsolGui") then
    LocalPlayer.PlayerGui.LowCoritsolGui:Destroy()
end

local farmingActive = false
local maxRange = 10000
local moveSpeed = 150
local teleportDelay = 0.15
local useTweening = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LowCoritsolGui"
ScreenGui.ResetOnSpawn = false

local coreGui = game:GetService("CoreGui")
pcall(function()
    ScreenGui.Parent = coreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 10)
FrameCorner.Parent = MainFrame

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImage"
BackgroundImage.Parent = MainFrame
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.ImageTransparency = 0.5
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0.05, 0, 0.02, 0)
TitleLabel.Size = UDim2.new(0.75, 0, 0.08, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "⚡ LowCoritsol Collector"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 2

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(0.84, 0, 0.02, 0)
CloseButton.Size = UDim2.new(0.12, 0, 0.07, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.ZIndex = 2

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseButton

local OpenIcon = Instance.new("TextButton")
OpenIcon.Name = "OpenIcon"
OpenIcon.Parent = ScreenGui
OpenIcon.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
OpenIcon.Position = UDim2.new(0.01, 0, 0.4, 0)
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Font = Enum.Font.SourceSansBold
OpenIcon.Text = "⚡"
OpenIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenIcon.TextSize = 22
OpenIcon.Visible = false
OpenIcon.Active = true
OpenIcon.Draggable = true

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 22)
OpenCorner.Parent = OpenIcon

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleButton.Position = UDim2.new(0.08, 0, 0.11, 0)
ToggleButton.Size = UDim2.new(0.84, 0, 0.12, 0)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "Auto-Farm: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.ZIndex = 2

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

local TweenButton = Instance.new("TextButton")
TweenButton.Name = "TweenButton"
TweenButton.Parent = MainFrame
TweenButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
TweenButton.Position = UDim2.new(0.08, 0, 0.25, 0)
TweenButton.Size = UDim2.new(0.84, 0, 0.11, 0)
TweenButton.Font = Enum.Font.SourceSansSemibold
TweenButton.Text = "Mode: Teleport"
TweenButton.TextColor3 = Color3.fromRGB(200, 200, 200)
TweenButton.TextSize = 13
TweenButton.ZIndex = 2

local TweenCorner = Instance.new("UICorner")
TweenCorner.CornerRadius = UDim.new(0, 6)
TweenCorner.Parent = TweenButton

local RangeInput = Instance.new("TextBox")
RangeInput.Name = "RangeInput"
RangeInput.Parent = MainFrame
RangeInput.BackgroundColor3 = Color3.fromRGB(35, 38, 50)
RangeInput.Position = UDim2.new(0.08, 0, 0.38, 0)
RangeInput.Size = UDim2.new(0.84, 0, 0.11, 0)
RangeInput.Font = Enum.Font.SourceSans
RangeInput.Text = "Distance: 10000"
RangeInput.TextColor3 = Color3.fromRGB(220, 220, 220)
RangeInput.TextSize = 14
RangeInput.ZIndex = 2

local RangeCorner = Instance.new("UICorner")
RangeCorner.CornerRadius = UDim.new(0, 4)
RangeCorner.Parent = RangeInput

local SpeedInput = Instance.new("TextBox")
SpeedInput.Name = "SpeedInput"
SpeedInput.Parent = MainFrame
SpeedInput.BackgroundColor3 = Color3.fromRGB(35, 38, 50)
SpeedInput.Position = UDim2.new(0.08, 0, 0.51, 0)
SpeedInput.Size = UDim2.new(0.84, 0, 0.11, 0)
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.Text = "Speed: 150"
SpeedInput.TextColor3 = Color3.fromRGB(220, 220, 220)
SpeedInput.TextSize = 14
SpeedInput.ZIndex = 2

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 4)
SpeedCorner.Parent = SpeedInput

local DelayInput = Instance.new("TextBox")
DelayInput.Name = "DelayInput"
DelayInput.Parent = MainFrame
DelayInput.BackgroundColor3 = Color3.fromRGB(35, 38, 50)
DelayInput.Position = UDim2.new(0.08, 0, 0.64, 0)
DelayInput.Size = UDim2.new(0.84, 0, 0.11, 0)
DelayInput.Font = Enum.Font.SourceSans
DelayInput.Text = "Delay: 0.15"
DelayInput.TextColor3 = Color3.fromRGB(220, 220, 220)
DelayInput.TextSize = 14
DelayInput.ZIndex = 2

local DelayCorner = Instance.new("UICorner")
DelayCorner.CornerRadius = UDim.new(0, 4)
DelayCorner.Parent = DelayInput

local ThemeInput = Instance.new("TextBox")
ThemeInput.Name = "ThemeInput"
ThemeInput.Parent = MainFrame
ThemeInput.BackgroundColor3 = Color3.fromRGB(25, 28, 40)
ThemeInput.Position = UDim2.new(0.08, 0, 0.77, 0)
ThemeInput.Size = UDim2.new(0.84, 0, 0.11, 0)
ThemeInput.Font = Enum.Font.SourceSansItalic
ThemeInput.Text = "Paste Roblox Image ID..."
ThemeInput.TextColor3 = Color3.fromRGB(180, 180, 200)
ThemeInput.TextSize = 13
ThemeInput.ZIndex = 2

local ThemeCorner = Instance.new("UICorner")
ThemeCorner.CornerRadius = UDim.new(0, 4)
ThemeCorner.Parent = ThemeInput

local function getRoot()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:FindFirstChild("HumanoidRootPart")
end

local function fireTouches(targetPart)
    local root = getRoot()
    if not root or not targetPart then return end
    if firetouchinterest then
        pcall(function()
            firetouchinterest(root, targetPart, 0)
            task.wait(0.01)
            firetouchinterest(root, targetPart, 1)
        end)
    end
end

local function moveCharacter(targetCFrame)
    local root = getRoot()
    if not root then return end
    if useTweening then
        local distance = (targetCFrame.Position - root.Position).Magnitude
        local tweenTime = distance / math.max(10, moveSpeed)
        local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(root, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
    else
        root.CFrame = targetCFrame
    end
end

local function processTarget(target)
    local root = getRoot()
    if not root or not target then return end
    local targetPart = target:IsA("BasePart") and target or target:FindFirstChildWhichIsA("BasePart")
    if not targetPart then return end
    local distance = (targetPart.Position - root.Position).Magnitude
    if distance <= maxRange then
        moveCharacter(targetPart.CFrame)
        fireTouches(targetPart)
        task.wait(teleportDelay)
    end
end

local function startFarming()
    task.spawn(function()
        while farmingActive do
            for _, item in ipairs(Workspace:GetDescendants()) do
                if not farmingActive then break end
                if item.Name == "LowCoritsol" or item:FindFirstChild("Cori") then
                    processTarget(item)
                end
            end
            task.wait(0.2)
        end
    end)
end

Workspace.DescendantAdded:Connect(function(descendant)
    if farmingActive then
        if descendant.Name == "LowCoritsol" or descendant.Name == "Cori" then
            task.wait(0.05)
            local target = descendant.Name == "Cori" and descendant.Parent or descendant
            processTarget(target)
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenIcon.Visible = true
end)

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenIcon.Visible = false
end)

ToggleButton.MouseButton1Click:Connect(function()
    farmingActive = not farmingActive
    if farmingActive then
        ToggleButton.Text = "Auto-Farm: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        startFarming()
    else
        ToggleButton.Text = "Auto-Farm: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

TweenButton.MouseButton1Click:Connect(function()
    useTweening = not useTweening
    if useTweening then
        TweenButton.Text = "Mode: Smooth Tween"
        TweenButton.TextColor3 = Color3.fromRGB(80, 220, 100)
    else
        TweenButton.Text = "Mode: Teleport"
        TweenButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

RangeInput.FocusLost:Connect(function()
    local val = tonumber(RangeInput.Text:match("%d+"))
    if val then maxRange = val end
    RangeInput.Text = "Distance: " .. tostring(maxRange)
end)

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text:match("%d+"))
    if val then moveSpeed = val end
    SpeedInput.Text = "Speed: " .. tostring(moveSpeed)
end)

DelayInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text:match("[%d%.]+"))
    if val then teleportDelay = val end
    DelayInput.Text = "Delay: " .. tostring(teleportDelay)
end)

ThemeInput.FocusLost:Connect(function()
    local assetId = ThemeInput.Text:match("%d+")
    if assetId then
        BackgroundImage.Image = "rbxassetid://" .. assetId
        ThemeInput.Text = "Theme Applied!"
        task.wait(1)
        ThemeInput.Text = "ID: " .. assetId
    else
        BackgroundImage.Image = ""
        ThemeInput.Text = "Paste Roblox Image ID..."
    end
end)

print("LowCoritsol Collector Loaded Successfully!")
