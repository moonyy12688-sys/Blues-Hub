copy me if u can
-- BLUES HUB | Mobile-friendly Roblox GUI
-- Designed for your own Roblox experience.

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("BluesHub")
if old then old:Destroy() end

local blue = Color3.fromRGB(30, 130, 255)
local dark = Color3.fromRGB(12, 20, 38)
local panel = Color3.fromRGB(20, 34, 58)
local white = Color3.fromRGB(235, 245, 255)

local gui = Instance.new("ScreenGui")
gui.Name = "BluesHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Loading screen
local loading = Instance.new("Frame")
loading.Size = UDim2.fromScale(1, 1)
loading.BackgroundColor3 = dark
loading.Parent = gui

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(1, 0, 0, 60)
loadText.Position = UDim2.new(0, 0, 0.38, 0)
loadText.BackgroundTransparency = 1
loadText.Text = "BLUES HUB"
loadText.TextColor3 = blue
loadText.TextScaled = true
loadText.Font = Enum.Font.GothamBold
loadText.Parent = loading

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(0.65, 0, 0, 10)
barBack.Position = UDim2.new(0.175, 0, 0.53, 0)
barBack.BackgroundColor3 = panel
barBack.Parent = loading
Instance.new("UICorner", barBack).CornerRadius = UDim.new(1, 0)

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = blue
bar.Parent = barBack
Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

TweenService:Create(bar, TweenInfo.new(1.4), {
    Size = UDim2.fromScale(1, 1)
}):Play()

task.wait(1.5)
loading:Destroy()

-- Small draggable opener
local opener = Instance.new("TextButton")
opener.Name = "OpenButton"
opener.Size = UDim2.fromOffset(58, 58)
opener.Position = UDim2.new(0, 18, 0.45, 0)
opener.BackgroundColor3 = blue
opener.Text = "BH"
opener.TextColor3 = white
opener.TextSize = 21
opener.Font = Enum.Font.GothamBold
opener.Parent = gui
Instance.new("UICorner", opener).CornerRadius = UDim.new(1, 0)

local openCorner = Instance.new("UIStroke", opener)
openCorner.Color = white
openCorner.Thickness = 1.5

-- Main menu
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(310, 350)
main.Position = UDim2.new(0.5, -155, 0.5, -175)
main.BackgroundColor3 = dark
main.Visible = false
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

local outline = Instance.new("UIStroke", main)
outline.Color = blue
outline.Thickness = 2

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 42)
title.Position = UDim2.fromOffset(10, 3)
title.BackgroundTransparency = 1
title.Text = "BLUES HUB"
title.TextColor3 = blue
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 20)
subtitle.Position = UDim2.fromOffset(10, 40)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Your game. Your settings."
subtitle.TextColor3 = white
subtitle.TextSize = 11
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = main

-- Tab buttons
local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(1, -16, 0, 36)
tabs.Position = UDim2.fromOffset(8, 67)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabs

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -116)
content.Position = UDim2.fromOffset(8, 108)
content.BackgroundColor3 = panel
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = blue
content.CanvasSize = UDim2.new()
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 9)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 9)
padding.PaddingBottom = UDim.new(0, 9)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = content

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject") and child ~= layout
            and child ~= padding then
            child:Destroy()
        end
    end
end

local function makeButton(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 37)
    b.BackgroundColor3 = dark
    b.TextColor3 = white
    b.Text = text
    b.TextSize = 13
    b.Font = Enum.Font.GothamSemibold
    b.AutoButtonColor = true
    b.Parent = content
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke", b)
    stroke.Color = blue
    stroke.Thickness = 1
    b.Activated:Connect(function()
        callback(b)
    end)
    return b
end

local function makeLabel(text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 26)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = blue
    l.TextSize = 13
    l.Font = Enum.Font.GothamBold
    l.Parent = content
    return l
end

local function makeSlider(label, min, max, initial, callback)
    local value = initial
    local b = makeButton(label .. ": " .. value, function() end)
    local dragging = false

    local function setValue(x)
        local ratio = math.clamp(
            (x - b.AbsolutePosition.X) / b.AbsoluteSize.X, 0, 1)
        value = math.floor(min + ratio * (max - min))
        b.Text = label .. ": " .. value
        callback(value)
    end

    b.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            setValue(input.Position.X)
        end
    end)

    b.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (
            input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseMovement
        ) then
            setValue(input.Position.X)
        end
    end)

    return b
end

local function getHumanoid()
    local character = player.Character
    return character and character:FindFirstChildOfClass("Humanoid")
end

local originalBrightness = Lighting.Brightness
local originalSaturation = 0
local colorEffect = Instance.new("ColorCorrectionEffect")
colorEffect.Name = "BluesHubColor"
colorEffect.Parent = Lighting

local originalSpeed = 16
local originalJump = 50

local function showHome()
    clearContent()
    makeLabel("WELCOME")
    makeButton("Blue theme enabled", function() end)
    makeButton("Refresh character", function()
        player:LoadCharacter()
    end)
    makeButton("Reset all settings", function()
        Lighting.Brightness = originalBrightness
        colorEffect.Saturation = originalSaturation
        local h = getHumanoid()
        if h then
            h.WalkSpeed = originalSpeed
            h.JumpPower = originalJump
        end
    end)
    makeLabel("Blues Hub is ready!")
end

local function showMovement()
    clearContent()
    makeLabel("MOVEMENT")
    makeSlider("Walk Speed", 8, 40, 16, function(v)
        local h = getHumanoid()
        if h then h.WalkSpeed = v end
    end)
    makeSlider("Jump Power", 20, 100, 50, function(v)
        local h = getHumanoid()
        if h then
            h.UseJumpPower = true
            h.JumpPower = v
        end
    end)
    makeButton("Reset movement", function()
        local h = getHumanoid()
        if h then
            h.WalkSpeed = originalSpeed
            h.JumpPower = originalJump
        end
    end)
end

local function showVisuals()
    clearContent()
    makeLabel("VISUAL SETTINGS")
    makeSlider("Brightness", -100, 100, 0, function(v)
        Lighting.Brightness = math.clamp(
            originalBrightness + v / 100, 0, 10)
    end)
    makeSlider("Saturation", -100, 100, 0, function(v)
        colorEffect.Saturation = v / 100
    end)
    makeButton("Reset visuals", function()
        Lighting.Brightness = originalBrightness
        colorEffect.Saturation = originalSaturation
    end)
end

local function makeTab(name, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1/3, -4, 1, 0)
    b.BackgroundColor3 = panel
    b.Text = name
    b.TextColor3 = white
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.Parent = tabs
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.Activated:Connect(callback)
end

makeTab("Home", showHome)
makeTab("Visuals", showVisuals)
makeTab("Movement", showMovement)

-- Toggle menu with the same opener
opener.Activated:Connect(function()
    main.Visible = not main.Visible
end)

-- Drag opener with mouse or touch
local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragStart
local startPosition

opener.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPosition = opener.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        opener.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

showHome()
print("Blues Hub loaded successfully!")
