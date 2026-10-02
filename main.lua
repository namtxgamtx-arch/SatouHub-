-- สร้าง GUI แบบเขียนสดเพื่อหลบ Anti-Cheat BAC-9205
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ลบ UI เก่าถ้ามีอยู่
if LocalPlayer.PlayerGui:FindFirstChild("SatouApp") then
    LocalPlayer.PlayerGui.SatouApp:Destroy()
end

-- สร้าง ScreenGui ใน PlayerGui ด้วยชื่อสุ่มหลบตรวจจับ
local SatouGui = Instance.new("ScreenGui")
SatouGui.Name = "SatouApp"
SatouGui.ResetOnSpawn = false
SatouGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

---------------------------------------------------------
-- 🔴 ปุ่มลอยเปิด/ปิดตัว S
---------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "S_Btn"
ToggleBtn.Parent = SatouGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.3, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "S"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 28
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local BtnCorner = Instance.new("UICorner", ToggleBtn)
BtnCorner.CornerRadius = UDim.new(1, 0)

local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(255, 50, 50)
BtnStroke.Thickness = 2

---------------------------------------------------------
-- 🖼️ หน้าต่างเมนูหลัก (Custom Design)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SatouGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local FrameCorner = Instance.new("UICorner", MainFrame)
FrameCorner.CornerRadius = UDim.new(0, 10)

local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(180, 0, 0)
FrameStroke.Thickness = 2

-- แถบชื่อเมนู
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "🔴 SATOU HUB (Safe Mode)"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18

local TitleCorner = Instance.new("UICorner", TitleLabel)
TitleCorner.CornerRadius = UDim.new(0, 10)

-- ปุ่มกดซ่อน/เปิด
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

---------------------------------------------------------
-- 🔘 ปุ่มฟังก์ชันต่างๆ
---------------------------------------------------------

-- 1. ปุ่ม Auto Steal (แบบ Safe)
local AutoStealBtn = Instance.new("TextButton")
AutoStealBtn.Parent = MainFrame
AutoStealBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
AutoStealBtn.Size = UDim2.new(0.8, 0, 0, 35)
AutoStealBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoStealBtn.Font = Enum.Font.SourceSansBold
AutoStealBtn.Text = "Auto Steal Eggs: OFF"
AutoStealBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
AutoStealBtn.TextSize = 16

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
TpBtn.Position = UDim2.new(0.1, 0, 0.50, 0)
TpBtn.Size = UDim2.new(0.8, 0, 0, 35)
TpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TpBtn.Font = Enum.Font.SourceSansBold
TpBtn.Text = "Safe TP to Spawn"
TpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TpBtn.TextSize = 16

Instance.new("UICorner", TpBtn).CornerRadius = UDim.new(0, 6)

TpBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local spawnPos = workspace:FindFirstChild("SpawnLocation") and workspace.SpawnLocation.CFrame or CFrame.new(0, 10, 0)
        local tween = TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = spawnPos + Vector3.new(0, 3, 0)})
        tween:Play()
    end
end)

-- 3. ปุ่มเพิ่ม WalkSpeed แบบปลอดภัย
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 35)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "WalkSpeed: 32 (Safe)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 16

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
