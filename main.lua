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
-- 🔴 ดัดแปลงปุ่ม Show Rayfield ให้เป็นปุ่ม S ของ Satou Hub
---------------------------------------------------------
task.spawn(function()
   task.wait(1)
   local coreGui = game:GetService("CoreGui")
   -- ค้นหาปุ่ม Rayfield เดิมบนหน้าจอแล้วเปลี่ยนรูปแบบ
   for _, gui in pairs(coreGui:GetChildren()) do
      if gui:IsA("ScreenGui") and (gui.Name:find("Rayfield") or gui:FindFirstChild("TextButton", true)) then
         for _, btn in pairs(gui:GetDescendants()) do
            if btn:IsA("TextButton") and (btn.Text:find("Rayfield") or btn.Text:find("Show") or btn.Text:find("Hide")) then
               -- เปลี่ยนเป็นสีและดีไซน์ Satou Hub
               btn.Text = "S"
               btn.Font = Enum.Font.SourceSansBold
               btn.TextSize = 28
               btn.TextColor3 = Color3.fromRGB(255, 255, 255)
               btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
               btn.Size = UDim2.new(0, 50, 0, 50)
               
               -- ปรับให้เป็นทรงกลม
               local corner = btn:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", btn)
               corner.CornerRadius = UDim.new(1, 0)
               
               -- เพิ่มเส้นขอบสีแดงเรืองแสง
               local stroke = btn:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", btn)
               stroke.Color = Color3.fromRGB(255, 60, 60)
               stroke.Thickness = 2
            end
         end
      end
   end
end)

---------------------------------------------------------
-- TAB 1: หน้าหลัก (Home)
---------------------------------------------------------
local HomeTab = Window:CreateTab("🏠 หน้าหลัก", 4483345998)

HomeTab:CreateSection("ยินดีต้อนรับสู่ Satou Hub")
HomeTab:CreateLabel("สคริปต์อย่างเป็นทางการของค่าย Satou Hub")
HomeTab:CreateLabel("กดปุ่ม 'S' สีแดงด้านบนเพื่อ เปิด/ปิด เมนูได้ทันที")

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
