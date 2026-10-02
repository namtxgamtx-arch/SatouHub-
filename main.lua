-- โหลด Fluent UI Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- สร้างหน้าต่างหลัก Satou Hub
local Window = Fluent:CreateWindow({
    Title = "Satou Hub",
    SubTitle = "by Satou",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

---------------------------------------------------------
-- 🔴 สร้างปุ่มลอยตัว S (เปิด/ปิด GUI ได้ 100% บนมือถือ)
---------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "SatouHubFloatingButton"

ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ToggleButton.Position = UDim2.new(0, 15, 0.3, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "S"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 30.000
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

UIStroke.Parent = ToggleButton
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 2.5

-- คำสั่งสั่งซ่อน/แสดงเมนู Fluent เมื่อแตะปุ่ม S
ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize()
end)

---------------------------------------------------------
-- TAB ต่างๆ ของ Satou Hub
---------------------------------------------------------
local Tabs = {
    Home = Window:AddTab({ Title = "🏠 หน้าหลัก", Icon = "home" }),
    Main = Window:AddTab({ Title = "🥚 Steal an Egg", Icon = "egg" }),
    Player = Window:AddTab({ Title = "⚙️ ตั้งค่าตัวละคร", Icon = "user" })
}

-- TAB: หน้าหลัก
Tabs.Home:AddParagraph({
    Title = "🔴 ยินดีต้อนรับสู่ Satou Hub",
    Content = "สคริปต์อย่างเป็นทางการของค่าย Satou Hub\nสามารถลากปุ่มตัว 'S' สีแดงไปวางตำแหน่งไหนก็ได้บนหน้าจอ และกดเพื่อ ย่อ/ขยาย หน้าต่างสคริปต์"
})

-- TAB: Steal an Egg
_G.AutoTpSteal = false

Tabs.Main:AddSection("ระบบฟาร์มไข่อัตโนมัติ")

local AutoStealToggle = Tabs.Main:AddToggle("AutoSteal", {Title = "Auto TP & Steal Eggs (วาร์ปขโมยไข่)", Default = false })

AutoStealToggle:OnChanged(function(Value)
    _G.AutoTpSteal = Value
    if Value then
        task.spawn(function()
            while _G.AutoTpSteal do
                local player = game.Players.LocalPlayer
                for _, v in pairs(workspace:GetDescendants()) do
                    if not _G.AutoTpSteal then break end
                    if v:IsA("ProximityPrompt") then
                        local eggPart = v.Parent
                        if eggPart and eggPart:IsA("BasePart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = player.Character.HumanoidRootPart
                            hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                            hrp.CFrame = eggPart.CFrame * CFrame.new(0, 2, 0)
                            hrp.Anchored = true
                            task.wait(0.15)
                            fireproximityprompt(v)
                            task.wait(0.35)
                            hrp.Anchored = false
                        end
                    end
                end
                task.wait(0.5)
            end
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end)
    else
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

Tabs.Main:AddSection("ระบบวาร์ป")

Tabs.Main:AddButton({
    Title = "Teleport to Spawn (วาร์ปกลับจุดเกิด)",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Anchored = false
            player.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

-- TAB: ตั้งค่าตัวละคร
Tabs.Player:AddSlider("WalkSpeedSlider", {
    Title = "WalkSpeed (ความเร็วเดิน)",
    Min = 16,
    Max = 200,
    Default = 16,
    Rounding = 0,
    Callback = function(Value)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Window:SelectTab(1)
