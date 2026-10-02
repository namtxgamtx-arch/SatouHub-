local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ลบ UI เก่าออกก่อน
if LocalPlayer.PlayerGui:FindFirstChild("SatouHubMain") then
    LocalPlayer.PlayerGui.SatouHubMain:Destroy()
end

-- สร้าง ScreenGui หลัก
local SatouGui = Instance.new("ScreenGui")
SatouGui.Name = "SatouHubMain"
SatouGui.ResetOnSpawn = false
SatouGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

---------------------------------------------------------
-- ⏳ 1. ระบบหน้าต่างโหลด (Loading Screen UI)
---------------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = SatouGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
LoadingFrame.Size = UDim2.new(0, 300, 0, 160)
LoadingFrame.Active = true

local LoadingCorner = Instance.new("UICorner", LoadingFrame)
LoadingCorner.CornerRadius = UDim.new(0, 12)

local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
LoadingStroke.Color = Color3.fromRGB(180, 0, 0)
LoadingStroke.Thickness = 2

-- หัวข้อ Hub
local TitleText = Instance.new("TextLabel")
TitleText.Parent = LoadingFrame
TitleText.Size = UDim2.new(1, 0, 0, 40)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "🔴 SATOU HUB"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 22

-- ข้อความสถานะการโหลด
local StatusText = Instance.new("TextLabel")
StatusText.Parent = LoadingFrame
StatusText.Position = UDim2.new(0, 0, 0.4, 0)
StatusText.Size = UDim2.new(1, 0, 0, 25)
StatusText.BackgroundTransparency = 1
StatusText.Font = Enum.Font.SourceSans
StatusText.Text = "กำลังโหลดข้อมูล..."
StatusText.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusText.TextSize = 15

-- พื้นหลังหลอดโหลด (ProgressBar Background)
local BarBackground = Instance.new("Frame")
BarBackground.Parent = LoadingFrame
BarBackground.Position = UDim2.new(0.1, 0, 0.65, 0)
BarBackground.Size = UDim2.new(0.8, 0, 0, 12)
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

Instance.new("UICorner", BarBackground).CornerRadius = UDim.new(1, 0)

-- แถบโหลดสีแดง (ProgressBar Fill)
local BarFill = Instance.new("Frame")
BarFill.Parent = BarBackground
BarFill.Position = UDim2.new(0, 0, 0, 0)
BarFill.Size = UDim2.new(0, 0, 1, 0) -- เริ่มต้นจาก 0%
BarFill.BackgroundColor3 = Color3.fromRGB(220, 30, 30)

Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

---------------------------------------------------------
-- 🔴 2. ปุ่มลอยเปิด/ปิดตัว S (สร้างไว้รอ)
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
ToggleBtn.Visible = false -- ซ่อนไว้ก่อน โหลดเสร็จค่อยแสดง

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Color3.fromRGB(255, 50, 50)
BtnStroke.Thickness = 2

---------------------------------------------------------
-- 🖼️ 3. หน้าต่างเมนูหลัก (Main GUI Frame)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SatouGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Visible = false -- ซ่อนไว้ก่อน
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local FrameStroke = Instance.new("UIStroke", MainFrame)
FrameStroke.Color = Color3.fromRGB(180, 0, 0)
FrameStroke.Thickness = 2

-- Header เมนูหลัก
local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = MainFrame
MainTitle.Size = UDim2.new(1, 0, 0, 35)
MainTitle.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.Text = "🔴 SATOU HUB | Steal an Egg"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 16

Instance.new("UICorner", MainTitle).CornerRadius = UDim.new(0, 10)

-- เชื่อมต่อปุ่ม S เปิด/ปิด หน้าต่าง
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

---------------------------------------------------------
-- ⚙️ 4. สคริปต์ควบคุมการรัน Loading Sequence
---------------------------------------------------------
task.spawn(function()
    -- แอนิเมชันหลอดโหลดช่วงที่ 1
    StatusText.Text = "กำลังตรวจสอบระบบ..."
    TweenService:Create(BarFill, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.4, 0, 1, 0)}):Play()
    task.wait(1.2)
    
    -- แอนิเมชันหลอดโหลดช่วงที่ 2
    StatusText.Text = "กำลังดาวน์โหลดมอดูล..."
    TweenService:Create(BarFill, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.8, 0, 1, 0)}):Play()
    task.wait(1)
    
    -- แอนิเมชันหลอดโหลดช่วงสุดท้าย (100%)
    StatusText.Text = "เสร็จสิ้น!"
    TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(0.6)
    
    -- ทำจางหน้าต่างโหลดแล้วเปิดใช้งาน Hub
    local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1})
    fadeTween:Play()
    fadeTween.Completed:Wait()
    
    LoadingFrame:Destroy() -- ลบหน้าต่างโหลดทิ้ง
    ToggleBtn.Visible = true -- แสดงปุ่มลอย S
    MainFrame.Visible = true -- แสดงหน้าต่างเมนูหลัก
end)
