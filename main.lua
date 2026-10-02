local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- 🔴 Asset ID โลโก้ตัว S ของ Satou Hub
local LOGO_ID = "rbxassetid://98993807671359"

-- ลบ UI เก่าออกก่อน
if LocalPlayer.PlayerGui:FindFirstChild("SatouHubMain") then
    LocalPlayer.PlayerGui.SatouHubMain:Destroy()
end

local SatouGui = Instance.new("ScreenGui")
SatouGui.Name = "SatouHubMain"
SatouGui.ResetOnSpawn = false
SatouGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

---------------------------------------------------------
-- ⏳ 1. หน้าต่างโหลดพร้อมรูปโลโก้ตัว S
---------------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = SatouGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LoadingFrame.Position = UDim2.new(0.5, -120, 0.5, -100)
LoadingFrame.Size = UDim2.new(0, 240, 0, 200)

Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)
local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
LoadingStroke.Color = Color3.fromRGB(180, 0, 0)
LoadingStroke.Thickness = 2

-- รูปโลโก้ตรงกลางหน้าต่างโหลด
local LogoImage = Instance.new("ImageLabel")
LogoImage.Parent = LoadingFrame
LogoImage.Size = UDim2.new(0, 80, 0, 80)
LogoImage.Position = UDim2.new(0.5, -40, 0.12, 0)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = LOGO_ID

-- ข้อความสถานะ
local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingFrame
StatusText.Position = UDim2.new(0, 0, 0.58, 0)
StatusText.Size = UDim2.new(1, 0, 0, 20)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.SourceSansBold
StatusText.Text = "Loading Satou Hub..."
StatusText.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusText.TextSize = 16

-- หลอดโหลด
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingFrame
BarBackground.Position = UDim2.new(0.1, 0, 0.78, 0)
BarBackground.Size = UDim2.new(0.8, 0, 0, 8)
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

Instance.new("UICorner", BarBackground).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(220, 30, 30)

Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

---------------------------------------------------------
-- 🔴 2. ปุ่มลอยรูปโลโก้ตัว S (ImageButton)
---------------------------------------------------------
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "S_Logo_Btn"
ToggleBtn.Parent = SatouGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Position = UDim2.new(0, 15, 0.3, 0)
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Image = LOGO_ID
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Visible = false

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(255, 50, 50)
BtnStroke.Thickness = 2

---------------------------------------------------------
-- 🖼️ 3. หน้าต่างเมนูหลัก
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SatouGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(180, 0, 0)
FrameStroke.Thickness = 2

-- แถบหัวข้อ
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Parent = MainFrame
HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(180, 0, 0)

Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 10)

local HeaderIcon = Instance.new("ImageLabel")
HeaderIcon.Parent = HeaderFrame
HeaderIcon.Position = UDim2.new(0, 8, 0, 5)
HeaderIcon.Size = UDim2.new(0, 30, 0, 30)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Image = LOGO_ID

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = HeaderFrame
MainTitle.Position = UDim2.new(0, 45, 0, 0)
MainTitle.Size = UDim2.new(1, -45, 1, 0)
MainTitle.BackgroundTransparency = 1
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.Text = "SATOU HUB | Steal an Egg"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 17
MainTitle.TextXAlignment = Enum.TextXAlignment.Left

-- เชื่อมต่อปุ่ม S เปิด/ปิด หน้าต่าง
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

---------------------------------------------------------
-- 🔘 4. ปุ่มฟังก์ชันต่างๆ
---------------------------------------------------------

-- 1. ปุ่ม Auto Steal (Safe Mode)
local AutoStealBtn = Instance.new("TextButton")
AutoStealBtn.Parent = MainFrame
AutoStealBtn.Position = UDim2.new(0.08, 0, 0.25, 0)
AutoStealBtn.Size = UDim2.new(0.84, 0, 0, 35)
AutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoStealBtn.Font = Enum.Font.SourceSansBold
AutoStealBtn.Text = "Auto Steal Eggs: OFF"
AutoStealBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoStealBtn.TextSize = 15

Instance.new("UICorner", AutoStealBtn).CornerRadius = UDim.new(0, 6)

_G.AutoSteal = false
AutoStealBtn.MouseButton1Click:Connect(function()
    _G.AutoSteal = not _G.AutoSteal
    if _G.AutoSteal then
        AutoStealBtn.Text = "Auto Steal Eggs: ON"
        AutoStealBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        
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
    else
        AutoStealBtn.Text = "Auto Steal Eggs: OFF"
        AutoStealBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- 2. ปุ่ม Safe TP Spawn
local TpBtn = Instance.new("TextButton")
TpBtn.Parent = MainFrame
TpBtn.Position = UDim2.new(0.08, 0, 0.48, 0)
TpBtn.Size = UDim2.new(0.84, 0, 0, 35)
TpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TpBtn.Font = Enum.Font.SourceSansBold
TpBtn.Text = "Safe TP to Spawn"
TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpBtn.TextSize = 15

Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 6)

TpBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local spawnPos = workspace:FindFirstChild("SpawnLocation") and workspace.SpawnLocation.CFrame or CFrame.new(0, 10, 0)
        local tween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = spawnPos + Vector3.new(0, 3, 0)})
        tween:Play()
    end
end)

-- 3. ปุ่ม WalkSpeed
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.08, 0, 0.71, 0)
SpeedBtn.Size = UDim2.new(0.84, 0, 0, 35)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "WalkSpeed: 32 (OFF)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 15

Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

local speedToggle = false
SpeedBtn.MouseButton1Click:Connect(function()
    speedToggle = not speedToggle
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if speedToggle then
            LocalPlayer.Character.Humanoid.WalkSpeed = 32
            SpeedBtn.Text = "WalkSpeed: 32 (ON)"
            SpeedBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            SpeedBtn.Text = "WalkSpeed: 16 (OFF)"
            SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end)

---------------------------------------------------------
-- ⚙️ 5. ทำแอนิเมชันตอนโหลด (Loading Sequence)
---------------------------------------------------------
task.spawn(function()
    TweenService:Create(BarFill, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.6, 0, 1, 0)}):Play()
    task.wait(1.2)
    
    StatusText.Text = "Ready!"
    TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(0.6)
    
    LoadingFrame:Destroy()
    ToggleBtn.Visible = true
    MainFrame.Visible = true
end)
