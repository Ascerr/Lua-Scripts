-- سكربت خرافي PREMIUM UI - RE-DESIGNED EDITION (V3)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local UIStroke_Main = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleBtn = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")
local UIStroke_Toggle = Instance.new("UIStroke")

-- إعدادات الشاشة الأساسية
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- تصميم زر الإخفاء والإظهار الجديد (Modern Minimalist)
ToggleBtn.Name = "ToggleMenu"
ToggleBtn.Parent = ScreenGui
ToggleBtn.Position = UDim2.new(0.02, 0, 0.1, 0)
ToggleBtn.Size = UDim2.new(0, 110, 0, 38)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.Text = "★ MARCO HUB ★"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 12

UICorner_Toggle.CornerRadius = UDim.new(0, 10)
UICorner_Toggle.Parent = ToggleBtn
UIStroke_Toggle.Color = Color3.fromRGB(255, 60, 60)
UIStroke_Toggle.Thickness = 1.5
UIStroke_Toggle.Parent = ToggleBtn

-- الواجهة الجديدة الفخمة (Sleek Dark Theme)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 340) 
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 16)
UICorner_Main.Parent = MainFrame

UIStroke_Main.Color = Color3.fromRGB(255, 50, 50)
UIStroke_Main.Thickness = 2
UIStroke_Main.Parent = MainFrame

-- البانر العلوي الفخم للعنوان
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Title.Text = "MARCO HUB v3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

local UICorner_Title = Instance.new("UICorner")
UICorner_Title.CornerRadius = UDim.new(0, 16)
UICorner_Title.Parent = Title

-- حاوية الأزرار المحسنة
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 0, 0, 55)
Container.Size = UDim2.new(1, 0, 1, -60)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 620)
Container.ScrollBarThickness = 3
Container.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)

UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- دالة تصميم الأزرار الفخمة والمحدثة
local function createNeonButton(text, order)
    local btn = Instance.new("TextButton")
    local corner = Instance.new("UICorner")
    local stroke = Instance.new("UIStroke")
    
    btn.Size = UDim2.new(0.92, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.LayoutOrder = order
    btn.Parent = Container
    
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    stroke.Color = Color3.fromRGB(45, 45, 45)
    stroke.Thickness = 1
    stroke.Parent = btn
    
    return btn, stroke
end

-- دالة إنشاء الصفوف الثنائية بالتصميم الجديد
local function createDoubleRow(text1, text2, order)
    local rowFrame = Instance.new("Frame")
    rowFrame.Size = UDim2.new(0.92, 0, 0, 40)
    rowFrame.BackgroundTransparency = 1
    rowFrame.LayoutOrder = order
    rowFrame.Parent = Container

    local btn1 = Instance.new("TextButton")
    btn1.Size = UDim2.new(0.48, 0, 1, 0)
    btn1.Position = UDim2.new(0, 0, 0, 0)
    btn1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn1.Text = text1
    btn1.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn1.Font = Enum.Font.GothamBold
    btn1.TextSize = 12
    btn1.Parent = rowFrame

local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 10)
    corner1.Parent = btn1
    local stroke1 = Instance.new("UIStroke")
    stroke1.Color = Color3.fromRGB(45, 45, 45)
    stroke1.Parent = btn1

    local btn2 = Instance.new("TextButton")
    btn2.Size = UDim2.new(0.48, 0, 1, 0)
    btn2.Position = UDim2.new(0.52, 0, 0, 0)
    btn2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn2.Text = text2
    btn2.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn2.Font = Enum.Font.GothamBold
    btn2.TextSize = 12
    btn2.Parent = rowFrame

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = btn2
    local stroke2 = Instance.new("UIStroke")
    stroke2.Color = Color3.fromRGB(45, 45, 45)
    stroke2.Parent = btn2

    return btn1, stroke1, btn2, stroke2
end

local lp = game.Players.LocalPlayer

-- [1] زر السرعة العالية
local SpeedBtn, SpeedStroke = createNeonButton("تفعيل السرعة العالية", 1)
local speedActive = false
SpeedBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        speedActive = not speedActive
        if speedActive then
            char.Humanoid.WalkSpeed = 150
            SpeedBtn.Text = "إيقاف السرعة العالية"
            SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            SpeedStroke.Color = Color3.fromRGB(255, 0, 0)
        else
            char.Humanoid.WalkSpeed = 16
            SpeedBtn.Text = "تفعيل السرعة العالية"
            SpeedBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SpeedStroke.Color = Color3.fromRGB(45, 45, 45)
        end
    end
end)

-- [2] زر القفز العالي
local JumpOnBtn, JumpOnStr, JumpOffBtn, JumpOffStr = createDoubleRow("تشغيل القفز العالي", "إيقاف القفز العالي", 2)

JumpOnBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        if char.Humanoid.UseJumpPower then
            char.Humanoid.JumpPower = 150
        else
            char.Humanoid.JumpHeight = 35
        end
        JumpOnBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        JumpOnStr.Color = Color3.fromRGB(255, 0, 0)
        JumpOffBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        JumpOffStr.Color = Color3.fromRGB(45, 45, 45)
    end
end)

JumpOffBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        if char.Humanoid.UseJumpPower then
            char.Humanoid.JumpPower = 50
        else
            char.Humanoid.JumpHeight = 7.2
        end
        JumpOffBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        JumpOffStr.Color = Color3.fromRGB(255, 0, 0)
        JumpOnBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        JumpOnStr.Color = Color3.fromRGB(45, 45, 45)
    end
end)

-- [3] الجيكبوينت
local savedCFrame = nil
local SavePosBtn, SavePosStr, TeleportPosBtn, TeleportPosStr = createDoubleRow("حفظ الموقف", "العودة للموقف", 3)

SavePosBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        SavePosBtn.Text = "تم الحفظ! ✔️"
        SavePosBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
        task.wait(1)
        SavePosBtn.Text = "حفظ الموقف"
        SavePosBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

TeleportPosBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if savedCFrame then
            char.HumanoidRootPart.CFrame = savedCFrame

TeleportPosBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            task.wait(0.2)
            TeleportPosBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        else
            TeleportPosBtn.Text = "لم تحفظ موقفاً!"
            task.wait(1)
            TeleportPosBtn.Text = "العودة للموقف"
        end
    end
end)

-- [4] اختراق الجدران
local noclipActive = false
game:GetService("RunService").Stepped:Connect(function()
    if noclipActive and lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
local NoclipBtn, NoclipStroke = createNeonButton("تفعيل اختراق الجدران", 4)
NoclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    if noclipActive then
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        NoclipStroke.Color = Color3.fromRGB(255, 0, 0)
    else
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NoclipStroke.Color = Color3.fromRGB(45, 45, 45)
    end
end)

-- [5] مشي على الهواء
local AirWalkBtn, AirWalkStroke = createNeonButton("مشي على الهواء", 5)
local airPlatform = nil
AirWalkBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        if not airPlatform then
            airPlatform = Instance.new("Part")
            airPlatform.Size = Vector3.new(10, 1, 10)
            airPlatform.Anchored = true
            airPlatform.Transparency = 0.6
            airPlatform.Color = Color3.fromRGB(255, 0, 0)
            airPlatform.Parent = workspace
            
            task.spawn(function()
                while airPlatform and airPlatform.Parent do
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        airPlatform.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                    end
                    task.wait(0.01)
                end
            end)
            AirWalkBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            AirWalkStroke.Color = Color3.fromRGB(255, 0, 0)
        else
            airPlatform:Destroy()
            airPlatform = nil
            AirWalkBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            AirWalkStroke.Color = Color3.fromRGB(45, 45, 45)
        end
    end
end)

-- [6] أداة التنقل
local TPToolBtn, TPToolStroke = createNeonButton("إعطاء أداة التنقل", 6)
TPToolBtn.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "Teleport Click - MARCO"
    tool.RequiresHandle = false
    
    tool.Activated:Connect(function()
        local mouse = lp:GetMouse()
        local char = lp.Character
        if char and char:FindFirstChild("HumanoidRootPart") and mouse.Hit then
            char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)
    
    tool.Parent = lp.Backpack
    TPToolBtn.Text = "تم التوصيل للحقيبة!"
    TPToolBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    task.wait(1.5)
    TPToolBtn.Text = "إعطاء أداة التنقل"
    TPToolBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)

-- [7] قتل الكل 😂
local KillAllBtn, KillAllStroke = createNeonButton("قتل الكل 😂", 7)
KillAllBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
KillAllBtn.MouseButton1Click:Connect(function()
    KillAllBtn.Text = "جاري التفعيل... ⚡"
    KillAllBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    KillAllStroke.Color = Color3.fromRGB(255, 0, 0)
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Destroy-Practice-servers-LOL-Tp-to-Greece-89845"))()
    end)
    task.wait(2)
    KillAllBtn.Text = "قتل الكل 😂"
    KillAllBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KillAllStroke.Color = Color3.fromRGB(45, 45, 45)
end)

-- [8] طيران عربي 🚀
local FlyArabicBtn, FlyArabicStroke = createNeonButton("طيران عربي 🚀", 8)
FlyArabicBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
FlyArabicBtn.MouseButton1Click:Connect(function()
    FlyArabicBtn.Text = "جاري التفعيل... 🛠️"
    FlyArabicBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    FlyArabicStroke.Color = Color3.fromRGB(255, 0, 0)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MrLamon/MLamon-Hub/refs/heads/main/Protected_8230641029096510.txt"))()
    end)
    task.wait(2)
    FlyArabicBtn.Text = "طيران عربي 🚀"
    FlyArabicBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    FlyArabicStroke.Color = Color3.fromRGB(45, 45, 45)
end)

-- [9] Knockback 🤪
local KnockbackBtn, KnockbackStroke = createNeonButton("Knockback 🤪", 9)
KnockbackBtn.TextColor3 = Color3.fromRGB(255, 120, 255)
KnockbackBtn.MouseButton1Click:Connect(function()
    KnockbackBtn.Text = "جاري تشغيل الضرب! 💥"
    KnockbackBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    KnockbackStroke.Color = Color3.fromRGB(255, 0, 0)
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GHSX-FLING-GUI-158629"))()
    end)
    task.wait(2)
    KnockbackBtn.Text = "Knockback 🤪"
    KnockbackBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KnockbackStroke.Color = Color3.fromRGB(45, 45, 45)
end)

-- [10] تسلق جدران 3D 🧱
local WallClimbBtn, WallClimbStroke = createNeonButton("تسلق جدران 3D 🧱", 10)
WallClimbBtn.TextColor3 = Color3.fromRGB(255, 255, 80)

local ClimbSpeed = 35
local ClimbingEnabled = false
local IsClimbing = false

local BillboardGui = Instance.new("BillboardGui")
local BBFrame = Instance.new("Frame")
local BBTitle = Instance.new("TextLabel")
local BBCorner = Instance.new("UICorner")
local BBStroke = Instance.new("UIStroke")

BillboardGui.Name = "ActiveClimb3D"
BillboardGui.Size = UDim2.new(0, 120, 0, 35)
BillboardGui.AlwaysOnTop = true
BillboardGui.ExtentsOffset = Vector3.new(0, 3.5, 0)

BBFrame.Size = UDim2.new(1, 0, 1, 0)
BBFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BBFrame.BackgroundTransparency = 0.15
BBFrame.Parent = BillboardGui

BBCorner.CornerRadius = UDim.new(0, 8)
BBCorner.Parent = BBFrame

BBStroke.Color = Color3.fromRGB(255, 0, 0)
BBStroke.Thickness = 1.5
BBStroke.Parent = BBFrame

BBTitle.Size = UDim2.new(1, 0, 1, 0)
BBTitle.BackgroundTransparency = 1
BBTitle.Text = "CLIMB ACTIVE"
BBTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
BBTitle.Font = Enum.Font.GothamBold
BBTitle.TextSize = 12
BBTitle.Parent = BBFrame

local function Update3DAttachment()
    local char = lp.Character
    if char and char:FindFirstChild("HumanoidRootPart") and ClimbingEnabled then
        BillboardGui.Adornee = char.HumanoidRootPart
        BillboardGui.Parent = char
    else
        BillboardGui.Parent = nil
    end
end

WallClimbBtn.MouseButton1Click:Connect(function()
    ClimbingEnabled = not ClimbingEnabled
    local char = lp.Character
    if ClimbingEnabled then
        WallClimbBtn.Text = "إيقاف تسلق جدران 3D"
        WallClimbBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        WallClimbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        WallClimbStroke.Color = Color3.fromRGB(255, 0, 0)
        Update3DAttachment()
    else
        WallClimbBtn.Text = "تسلق جدران 3D 🧱"
        WallClimbBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        WallClimbBtn.TextColor3 = Color3.fromRGB(255, 255, 80)
        WallClimbStroke.Color = Color3.fromRGB(45, 45, 45)
        Update3DAttachment()
        if IsClimbing and char and char:FindFirstChild("Humanoid") then
            IsClimbing = false
            char.Humanoid.AutoRotate = true
        end
    end
end)

lp.CharacterAdded:Connect(function()
    task.wait(1)
    Update3DAttachment()
end)

local function CheckForWall(char)
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Exclude
    return workspace:Raycast(root.Position, root.CFrame.LookVector * 3, params)
end

game:GetService("RunService").Heartbeat:Connect(function()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    if ClimbingEnabled and CheckForWall(char) and hum.MoveDirection.Magnitude > 0 then
        if not IsClimbing then IsClimbing = true hum.AutoRotate = false end
        root.Velocity = Vector3.new(0, ClimbSpeed, 0)
    else
        if IsClimbing then IsClimbing = false hum.AutoRotate = true end
    end
end)

-- ==========================================
-- [11] واجهة قائمة السم الجديدة والمستقلة 🧪✨
-- ==========================================
local ToxicTpBtn, ToxicTpStroke = createNeonButton("تنقل عبر السم 🧪", 11)
ToxicTpBtn.TextColor3 = Color3.fromRGB(0, 255, 160)

local ListFrame = Instance.new("Frame")
local ListCorner = Instance.new("UICorner")
local ListStroke = Instance.new("UIStroke")
local ListTitle = Instance.new("TextLabel")
local ListContainer = Instance.new("ScrollingFrame")
local ListLayout = Instance.new("UIListLayout")
local CloseListBtn = Instance.new("TextButton")

ListFrame.Name = "ToxicTpMenu"
ListFrame.Parent = ScreenGui
ListFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
ListFrame.Position = UDim2.new(0.56, 0, 0.2, 0)
ListFrame.Size = UDim2.new(0, 210, 0, 300)
ListFrame.Visible = false
ListFrame.Active = true
ListFrame.Draggable = true

ListCorner.CornerRadius = UDim.new(0, 14)
ListCorner.Parent = ListFrame
ListStroke.Color = Color3.fromRGB(0, 255, 160)
ListStroke.Thickness = 1.5
ListStroke.Parent = ListFrame

ListTitle.Size = UDim2.new(1, 0, 0, 45)
ListTitle.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
ListTitle.Text = "قائمة أهداف السم 🧪"
ListTitle.TextColor3 = Color3.fromRGB(0, 255, 160)
ListTitle.TextSize = 13
ListTitle.Font = Enum.Font.GothamBold
ListTitle.Parent = ListFrame
Instance.new("UICorner", ListTitle).CornerRadius = UDim.new(0, 14)

ListContainer.Position = UDim2.new(0, 0, 0, 50)
ListContainer.Size = UDim2.new(1, 0, 1, -85)
ListContainer.BackgroundTransparency = 1
ListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ListContainer.ScrollBarThickness = 3
ListContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 160)
ListContainer.Parent = ListFrame

ListLayout.Padding = UDim.new(0, 6)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ListContainer

CloseListBtn.Size = UDim2.new(0.9, 0, 0, 30)
CloseListBtn.Position = UDim2.new(0.05, 0, 1, -35)
CloseListBtn.BackgroundColor3 = Color3.fromRGB(40, 15, 15)
CloseListBtn.Text = "إغلاق القائمة"
CloseListBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseListBtn.Font = Enum.Font.GothamBold
CloseListBtn.TextSize = 12
CloseListBtn.Parent = ListFrame
Instance.new("UICorner", CloseListBtn).CornerRadius = UDim.new(0, 8)

local function UpdatePlayersList()
    for _, child in pairs(ListContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local count = 0
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= lp then
            count = count + 1
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(0.95, 0, 0, 32)
            pBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            pBtn.Text = player.Name
            pBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
            pBtn.Font = Enum.Font.Gotham

pBtn.TextSize = 13
            pBtn.Parent = ListContainer
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 8)
            
            pBtn.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    lp.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                end
            end)
        end
    end
    ListContainer.CanvasSize = UDim2.new(0, 0, 0, count * 38)
end

ToxicTpBtn.MouseButton1Click:Connect(function()
    ListFrame.Visible = not ListFrame.Visible
    if ListFrame.Visible then
        UpdatePlayersList()
    end
end)

CloseListBtn.MouseButton1Click:Connect(function()
    ListFrame.Visible = false
end)

game.Players.PlayerAdded:Connect(function() if ListFrame.Visible then UpdatePlayersList() end end)
game.Players.PlayerRemoving:Connect(function() if ListFrame.Visible then UpdatePlayersList() end end)
