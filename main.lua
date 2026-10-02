local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

---------------------------------------------------------
-- ⚙️ 1. ตั้งค่าธีมและโลโก้ (ปรับแต่งความสวยงามได้ที่นี่)
---------------------------------------------------------
local LOGO_ID = "rbxassetid://98993807671359"

local Theme = {
    MainColor   = Color3.fromRGB(255, 45, 70),   -- สีหลัก/ขอบ/สวิตช์ (แดงนีออน)
    Background  = Color3.fromRGB(18, 18, 24),    -- สีพื้นหลังหลัก
    HeaderBg    = Color3.fromRGB(25, 25, 35),    -- สีแถบหัวข้อด้านบน
    ItemBg      = Color3.fromRGB(28, 28, 38),    -- สีพื้นหลังปุ่ม/สวิตช์
    TextColor   = Color3.fromRGB(255, 255, 255)  -- สีตัวอักษร
}

-- ลบ UI เก่าป้องกันการรันซ้ำ
if LocalPlayer.PlayerGui:FindFirstChild("SatouHubEasy") then
    LocalPlayer.PlayerGui.SatouHubEasy:Destroy()
end

local SatouGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
SatouGui.Name = "SatouHubEasy"
SatouGui.ResetOnSpawn = false

---------------------------------------------------------
-- ⏳ 2. หน้าต่าง Loading แบบสั้น
---------------------------------------------------------
local LoadingFrame = Instance.new("Frame", SatouGui)
LoadingFrame.Size = UDim2.new(0, 240, 0, 200)
LoadingFrame.Position = UDim2.new(0.5, -120, 0.5, -100)
LoadingFrame.BackgroundColor3 = Theme.Background
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 14)

local LoadStroke = Instance.new("UIStroke", LoadingFrame)
LoadStroke.Color = Theme.MainColor
LoadStroke.Thickness = 2

local LogoImg = Instance.new("ImageLabel", LoadingFrame)
LogoImg.Size = UDim2.new(0, 80, 0, 80)
LogoImg.Position = UDim2.new(0.5, -40, 0.15, 0)
LogoImg.BackgroundTransparency = 1
LogoImg.Image = LOGO_ID

local StatusLbl = Instance.new("TextLabel", LoadingFrame)
StatusLbl.Size = UDim2.new(1, 0, 0, 20)
StatusLbl.Position = UDim2.new(0, 0, 0.6, 0)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Font = Enum.Font.GothamBold
StatusLbl.Text = "LOADING SATOU HUB..."
StatusLbl.TextColor3 = Theme.TextColor
StatusLbl.TextSize = 12

local BarBg = Instance.new("Frame", LoadingFrame)
BarBg.Size = UDim2.new(0.8, 0, 0, 6)
BarBg.Position = UDim2.new(0.1, 0, 0.8, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Theme.MainColor
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

---------------------------------------------------------
-- 🖼️ 3. หน้าต่างเมนูหลัก & ปุ่มลอย
---------------------------------------------------------
-- ปุ่มลอยโลโก้ S
local ToggleBtn = Instance.new("ImageButton", SatouGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.35, 0)
ToggleBtn.BackgroundColor3 = Theme.Background
ToggleBtn.Image = LOGO_ID
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local BtnStroke = Instance.new("UIStroke", ToggleBtn)
BtnStroke.Color = Theme.MainColor
BtnStroke.Thickness = 2

-- หน้าต่างหลัก
local MainFrame = Instance.new("Frame", SatouGui)
MainFrame.Size = UDim2.new(0, 310, 0, 230)
MainFrame.Position = UDim2.new(0.5, -155, 0.5, -115)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Theme.MainColor
MainStroke.Thickness = 1.5

-- แถบ Header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Theme.HeaderBg
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 14)

local HeaderTitle = Instance.new("TextLabel", Header)
HeaderTitle.Size = UDim2.new(1, -50, 1, 0)
HeaderTitle.Position = UDim2.new(0, 12, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "SATOU HUB"
HeaderTitle.TextColor3 = Theme.TextColor
HeaderTitle.TextSize = 14
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่มปิด (✕)
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -12)
CloseBtn.BackgroundColor3 = Theme.MainColor
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.MainColor
CloseBtn.TextSize = 13
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

---------------------------------------------------------
-- 🛠️ 4. ฟังก์ชัน Helper (สร้างปุ่ม/สวิตช์ง่ายๆ ในบรรทัดเดียว)
---------------------------------------------------------
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -50)
Container.Position = UDim2.new(0, 10, 0, 45)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 6)

-- 🟢 ฟังก์ชันสร้างสวิตช์ เปิด/ปิด (Toggle)
local function AddToggle(title, defaultState, callback)
    local Frame = Instance.new("Frame", Container)
    Frame.Size = UDim2.new(1, 0, 0, 38)
    Frame.BackgroundColor3 = Theme.ItemBg
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamMedium
    Label.Text = title
    Label.TextColor3 = Theme.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("TextButton", Frame)
    Switch.Size = UDim2.new(0, 38, 0, 18)
    Switch.Position = UDim2.new(1, -46, 0.5, -9)
    Switch.BackgroundColor3 = defaultState and Theme.MainColor or Color3.fromRGB(50, 50, 60)
    Switch.Text = ""
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Dot = Instance.new("Frame", Switch)
    Dot.Size = UDim2.new(0, 14, 0, 14)
    Dot.Position = defaultState and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

    local state = defaultState
    Switch.MouseButton1Click:Connect(function()
        state = not state
        local pos = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        local bg = state and Theme.MainColor or Color3.fromRGB(50, 50, 60)
        TweenService:Create(Dot, TweenInfo.new(0.15), {Position = pos}):Play()
        TweenService:Create(Switch, TweenInfo.new(0.15), {BackgroundColor3 = bg}):Play()
        callback(state)
    end)
end

-- 🔵 ฟังก์ชันสร้างปุ่มกดครั้งเดียว (Button)
local function AddButton(title, callback)
    local Btn = Instance.new("TextButton", Container)
    Btn.Size = UDim2.new(1, 0, 0, 38)
    Btn.BackgroundColor3 = Theme.ItemBg
    Btn.Font = Enum.Font.GothamMedium
    Btn.Text = title
    Btn.TextColor3 = Theme.TextColor
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)

    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0, 36)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 38)}):Play()
        callback()
    end)
end

---------------------------------------------------------
-- 🚀 5. เขียนเพิ่มฟังก์ชันใช้งานตรงนี้ (สั้น สดใส ง่าย!)
---------------------------------------------------------

-- ตัวอย่างที่ 1: สวิตช์ Auto Steal
AddToggle("Auto Steal Eggs", false, function(value)
    _G.AutoSteal = value
    print("Auto Steal Status:", value)
end)

-- ตัวอย่างที่ 2: สวิตช์เพิ่มความเร็ว
AddToggle("Boost WalkSpeed", false, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value and 32 or 16
    end
end)

-- ตัวอย่างที่ 3: ปุ่มกดวาร์ปกลับจุดเกิด (Button)
AddButton("Teleport to Spawn", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    end
end)

---------------------------------------------------------
-- ⚙️ 6. ระบบเริ่มทำงาน (Animation โหลด)
---------------------------------------------------------
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

task.spawn(function()
    TweenService:Create(BarFill, TweenInfo.new(1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1.1)
    LoadingFrame:Destroy()
    ToggleBtn.Visible = true
    MainFrame.Visible = true
end)
