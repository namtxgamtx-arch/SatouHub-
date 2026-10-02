local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local LOGO_ID = "rbxassetid://98993807671359"

-- ลบ UI เก่าถ้ามีอยู่
if LocalPlayer.PlayerGui:FindFirstChild("SatouHubModern") then
    LocalPlayer.PlayerGui.SatouHubModern:Destroy()
end

local SatouGui = Instance.new("ScreenGui")
SatouGui.Name = "SatouHubModern"
SatouGui.ResetOnSpawn = false
SatouGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

---------------------------------------------------------
-- ⏳ 1. Loading Screen
---------------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = SatouGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.BackgroundTransparency = 0.05
LoadingFrame.Position = UDim2.new(0.5, -125, 0.5, -110)
LoadingFrame.Size = UDim2.new(0, 250, 0, 220)

Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 16)
local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
LoadingStroke.Color = Color3.fromRGB(235, 35, 60)
LoadingStroke.Thickness = 1.8
LoadingStroke.Transparency = 0.2

local LogoImage = Instance.new("ImageLabel")
LogoImage.Parent = LoadingFrame
LogoImage.Size = UDim2.new(0, 85, 0, 85)
LogoImage.Position = UDim2.new(0.5, -42, 0.12, 0)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = LOGO_ID

local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingFrame
StatusText.Position = UDim2.new(0, 0, 0.58, 0)
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.GothamBold
StatusText.Text = "INITIALIZING SATOU HUB..."
StatusText.TextColor3 = Color3.fromRGB(200, 200, 210)
StatusText.TextSize = 12

local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingFrame
BarBackground.Position = UDim2.new(0.1, 0, 0.78, 0)
BarBackground.Size = UDim2.new(0.8, 0, 0, 6)
BarBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 40)

Instance.new("UICorner", BarBackground).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 45, 70)

Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

---------------------------------------------------------
-- 🔴 2. ปุ่มลอยเปิด/ปิดแบบส่องแสง (Glow ImageButton)
---------------------------------------------------------
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "S_Logo_Btn"
ToggleBtn.Parent = SatouGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
ToggleBtn.Position = UDim2.new(0, 20, 0.35, 0)
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Image = LOGO_ID
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = false

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(255, 45, 70)
BtnStroke.Thickness = 2

---------------------------------------------------------
-- 🖼️ 3. หน้าต่างเมนูหลัก Modern Dark
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SatouGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 45, 70)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3

-- แถบ Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.BackgroundTransparency = 0.2

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local HeaderIcon = Instance.new("ImageLabel")
HeaderIcon.Parent = Header
HeaderIcon.Position = UDim2.new(0, 10, 0, 6)
HeaderIcon.Size = UDim2.new(0, 30, 0, 30)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Image = LOGO_ID

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Parent = Header
HeaderTitle.Position = UDim2.new(0, 48, 0, 0)
HeaderTitle.Size = UDim2.new(1, -90, 1, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "SATOU HUB  •  Steal an Egg"
HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderTitle.TextSize = 13
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

---------------------------------------------------------
-- ❌ เพิ่มปุ่มปิดหน้าต่าง (Close Button)
---------------------------------------------------------
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Parent = Header
CloseBtn.Position = UDim2.new(1, -35, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 45, 70)
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 14

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- เอฟเฟกต์ชี้/กด และฟังชันสั่งปิดหน้าต่าง
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

---------------------------------------------------------
-- ⚙️ คอนเทนเนอร์รายการปุ่ม
---------------------------------------------------------
local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 10, 0, 50)
Container.Size = UDim2.new(1, -20, 1, -60)
Container.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Container)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)

-- ฟังก์ชันสร้างปุ่ม Toggle
local function CreateToggle(name, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = Container
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamMedium
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local SwitchBg = Instance.new("TextButton")
    SwitchBg.Parent = Frame
    SwitchBg.Position = UDim2.new(1, -50, 0.5, -10)
    SwitchBg.Size = UDim2.new(0, 40, 0, 20)
    SwitchBg.BackgroundColor3 = default and Color3.fromRGB(255, 45, 70) or Color3.fromRGB(50, 50, 60)
    SwitchBg.Text = ""
    
    Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame")
    Dot.Parent = SwitchBg
    Dot.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    Dot.Size = UDim2.new(0, 16, 0, 16)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local toggled = default
    SwitchBg.MouseButton1Click:Connect(function()
        toggled = not toggled
        local targetPos = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetBg = toggled and Color3.fromRGB(255, 45, 70) or Color3.fromRGB(50, 50, 60)
        
        TweenService:Create(Dot, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = targetBg}):Play()
        
        callback(toggled)
    end)
end

-- 1. Toggle: Auto Steal
_G.AutoSteal = false
CreateToggle("Auto Steal Eggs", false, function(state)
    _G.AutoSteal = state
    if _G.AutoSteal then
        task.spawn(function()
            while _G.AutoSteal do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if not _G.AutoSteal then break end
                        if v:IsA("ProximityPrompt") then
                            local eggPart = v.Parent
                            if eggPart and eggPart:IsA("BasePart") then
                                local hrp = LocalPlayer.Character.HumanoidRootPart
                                local targetCFrame = eggPart.CFrame * CFrame.new(0, 2, 0)
                                local dist = (hrp.Position - eggPart.Position).Magnitude
                                
                                local tween = TweenService:Create(hrp, TweenInfo.new(dist / 80, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
                                tween:Play()
                                tween.Completed:Wait()
                                
                                task.wait(0.2)
                                fireproximityprompt(v)
                                task.wait(0.5)
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

-- 2. Toggle: Fast WalkSpeed
CreateToggle("Boost WalkSpeed (32)", false, function(state)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = state and 32 or 16
    end
end)

-- 3. Toggle: Safe Teleport to Spawn
CreateToggle("Teleport Safe Zone", false, function(state)
    if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local spawnPos = workspace:FindFirstChild("SpawnLocation") and workspace.SpawnLocation.CFrame or CFrame.new(0, 10, 0)
        TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = spawnPos + Vector3.new(0, 3, 0)}):Play()
    end
end)

---------------------------------------------------------
-- ⚙️ Animation ระบบสลับการแสดงผล
---------------------------------------------------------
ToggleBtn.MouseButton1Click:Connect(function()
    TweenService:Create(ToggleBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 46, 0, 46)}):Play()
    task.wait(0.1)
    TweenService:Create(ToggleBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 52, 0, 52)}):Play()
    
    MainFrame.Visible = not MainFrame.Visible
end)

task.spawn(function()
    StatusText.Text = "LOADING ASSETS..."
    TweenService:Create(BarFill, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.6, 0, 1, 0)}):Play()
    task.wait(1)
    
    StatusText.Text = "READY TO FLY!"
    TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(0.6)
    
    TweenService:Create(LoadingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    task.wait(0.3)
    
    LoadingFrame:Destroy()
    ToggleBtn.Visible = true
    MainFrame.Visible = true
end)
