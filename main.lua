-- โหลด Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- สร้างหน้าต่างหลักค่าย Satou Hub
local Window = Rayfield:CreateWindow({
   Name = "🔴 SATOU HUB | Steal an Egg",
   LoadingTitle = "SATOU HUB",
   LoadingSubtitle = "Created by Satou",
   Theme = "DarkRed",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SatouHubConfig",
      FileName = "Configuration"
   },
   KeySystem = false
})

---------------------------------------------------------
-- 🔴 ระบบปุ่มลอย Satou Hub (แก้ไขระบบสั่งเปิด/ปิดให้ทำงานได้จริง)
---------------------------------------------------------
local VirtualInputManager = game:GetService("VirtualInputManager")
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "SatouHubToggleButton"

ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleButton.Position = UDim2.new(0, 10, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "S"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 32.000
ToggleButton.Active = true
ToggleButton.Draggable = true

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleButton

UIStroke.Parent = ToggleButton
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 2

-- แก้ไขจุดนี้: สั่งให้กดปุ่มจำลองเมื่อแตะปุ่ม S
ToggleButton.MouseButton1Click:Connect(function()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.K, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.K, false, game)
end)

---------------------------------------------------------
-- TAB 1: หน้าหลัก (Home)
---------------------------------------------------------
local HomeTab = Window:CreateTab("🏠 หน้าหลัก", 4483345998)

HomeTab:CreateSection("ยินดีต้อนรับสู่ Satou Hub")
HomeTab:CreateLabel("สคริปต์อย่างเป็นทางการของค่าย Satou Hub")
HomeTab:CreateLabel("กดที่ปุ่ม 'S' เพื่อ ซ่อน/เปิด เมนูได้เลย")

---------------------------------------------------------
-- TAB 2: ฟังก์ชันขโมยไข่ (Steal an Egg)
---------------------------------------------------------
local EggTab = Window:CreateTab("🥚 Steal an Egg", 4483345998)

_G.AutoTpSteal = false

EggTab:CreateSection("ระบบฟาร์มไข่อัตโนมัติ")

EggTab:CreateToggle({
   Name = "Auto TP & Steal Eggs (วาร์ปขโมยไข่)",
   CurrentValue = false,
   Flag = "AutoStealToggle",
   Callback = function(Value)
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
   end,
})

EggTab:CreateSection("ระบบวาร์ป")

EggTab:CreateButton({
   Name = "Teleport to Spawn (วาร์ปกลับจุดเกิด)",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         player.Character.HumanoidRootPart.Anchored = false
         player.Character.HumanoidRootPart.CFrame = workspace.SpawnLocation.CFrame + Vector3.new(0, 3, 0)
      end
   end,
})

---------------------------------------------------------
-- TAB 3: ตั้งค่าตัวละคร (Player Settings)
---------------------------------------------------------
local MiscTab = Window:CreateTab("⚙️ ตั้งค่าตัวละคร", 4483345998)

MiscTab:CreateSlider({
   Name = "WalkSpeed (ความเร็วเดิน)",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})
