-- โหลด Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- สร้างหน้าต่างหลักค่าย Satou Hub (ธีมสีแดงตามโลโก้)
local Window = Rayfield:CreateWindow({
   Name = "🔴 SATOU HUB | Steal an Egg",
   LoadingTitle = "SATOU HUB",
   LoadingSubtitle = "Created by Satou",
   Theme = "DarkRed", -- ปรับโทนสีแดงให้เข้ากับโลโก้ตัว S
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "SatouHubConfig",
      FileName = "Configuration"
   },
   Discord = {
      Enabled = false,
      Invite = "discord.gg/satouhub",
      RememberJoins = true
   },
   KeySystem = false
})

-- ป็อปอัปต้อนรับสไตล์ Satou Hub
Rayfield:Notify({
   Title = "WELCOME TO SATOU HUB!",
   Content = "โหลดสคริปต์ค่าย Satou Hub เรียบร้อยแล้ว!",
   Duration = 5,
   Image = 4483345998,
})

---------------------------------------------------------
-- TAB 1: หน้าหลัก / ประกาศข่าวสาร (Home)
---------------------------------------------------------
local HomeTab = Window:CreateTab("🏠 หน้าหลัก", 4483345998)

HomeTab:CreateSection("ยินดีต้อนรับสู่ Satou Hub")
HomeTab:CreateLabel("สคริปต์อย่างเป็นทางการของค่าย Satou Hub")
HomeTab:CreateLabel("เวอร์ชัน: v1.0.0 (รองรับ iOS / Android)")

HomeTab:CreateSection("ชุมชน & การติดต่อ")
HomeTab:CreateButton({
   Name = "คัดลอกลิงก์ Discord ค่าย Satou Hub",
   Callback = function()
      setclipboard("https://discord.gg/satouhub")
      Rayfield:Notify({Title = "Satou Hub System", Content = "คัดลอกลิงก์ Discord เรียบร้อย!", Duration = 3})
   end,
})

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

MiscTab:CreateSection("ปรับแต่งความเร็ว")

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

MiscTab:CreateSlider({
   Name = "JumpPower (แรงกระโดด)",
   Range = {50, 300},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
      end
   end,
})
