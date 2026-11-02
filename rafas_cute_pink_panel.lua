-- 🌸 rafa's cute pink panel 🌸
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

if game.CoreGui:FindFirstChild("RafaPinkPanel") then
    game.CoreGui.RafaPinkPanel:Destroy()
end

local Pink = Color3.fromRGB(255, 182, 213)
local DarkPink = Color3.fromRGB(255, 105, 180)
local LightPink = Color3.fromRGB(255, 228, 240)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RafaPinkPanel"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- Botão flutuante
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(0, 20, 0.5, -27)
Toggle.BackgroundColor3 = Pink
Toggle.Text = "🌸"
Toggle.TextSize = 28
Toggle.Font = Enum.Font.GothamBold
Toggle.BorderSizePixel = 0
Toggle.Parent = ScreenGui
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Toggle).Color = DarkPink

-- Painel
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 260, 0, 380)
Main.Position = UDim2.new(0, 90, 0.5, -190)
Main.BackgroundColor3 = LightPink
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)
local ms = Instance.new("UIStroke", Main); ms.Color = DarkPink; ms.Thickness = 2

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Pink
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 18)
local fix = Instance.new("Frame")
fix.Size = UDim2.new(1, 0, 0, 18); fix.Position = UDim2.new(0, 0, 1, -18)
fix.BackgroundColor3 = Pink; fix.BorderSizePixel = 0; fix.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 40, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🌸 rafa's panel 🌸"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 28, 0, 28)
Close.Position = UDim2.new(1, -34, 0, 8)
Close.BackgroundColor3 = DarkPink
Close.Text = "×"; Close.TextSize = 20; Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Color3.new(1,1,1); Close.BorderSizePixel = 0; Close.Parent = TitleBar
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

-- Arrastar
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = i.Position; startPos = Main.Position
        i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TitleBar.InputChanged:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then dragInput = i end
end)
UserInputService.InputChanged:Connect(function(i)
    if i == dragInput and dragging then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

Close.MouseButton1Click:Connect(function() Main.Visible = false end)
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- Scroll
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.BackgroundTransparency = 1; Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4; Scroll.ScrollBarImageColor3 = DarkPink
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0); Scroll.Parent = Main
local LL = Instance.new("UIListLayout", Scroll)
LL.Padding = UDim.new(0, 8); LL.SortOrder = Enum.SortOrder.LayoutOrder
LL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, LL.AbsoluteContentSize.Y + 10)
end)

-- Helper toggle
local function makeToggle(name, emoji, cb)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -8, 0, 40)
    Btn.BackgroundColor3 = Pink; Btn.Text = ""; Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false; Btn.Parent = Scroll
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", Btn); s.Color = DarkPink; s.Thickness = 1.5
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, -60, 1, 0); L.Position = UDim2.new(0, 12, 0, 0)
    L.BackgroundTransparency = 1; L.Text = emoji .. "  " .. name
    L.TextColor3 = Color3.new(1,1,1); L.TextSize = 14
    L.Font = Enum.Font.GothamSemibold; L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = Btn
    local Ind = Instance.new("Frame")
    Ind.Size = UDim2.new(0, 40, 0, 20); Ind.Position = UDim2.new(1, -50, 0.5, -10)
    Ind.BackgroundColor3 = Color3.new(1,1,1); Ind.BorderSizePixel = 0; Ind.Parent = Btn
    Instance.new("UICorner", Ind).CornerRadius = UDim.new(1, 0)
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 16, 0, 16); Dot.Position = UDim2.new(0, 2, 0.5, -8)
    Dot.BackgroundColor3 = DarkPink; Dot.BorderSizePixel = 0; Dot.Parent = Ind
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)
    local en = false
    Btn.MouseButton1Click:Connect(function()
        en = not en
        if en then
            Dot:TweenPosition(UDim2.new(0, 22, 0.5, -8), "Out", "Quad", 0.15, true)
            Ind.BackgroundColor3 = DarkPink; Dot.BackgroundColor3 = Color3.new(1,1,1)
        else
            Dot:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.15, true)
            Ind.BackgroundColor3 = Color3.new(1,1,1); Dot.BackgroundColor3 = DarkPink
        end
        cb(en)
    end)
end

-- Slider
local function makeSlider(name, emoji, min, max, default, cb)
    local F = Instance.new("Frame")
    F.Size = UDim2.new(1, -8, 0, 60); F.BackgroundColor3 = Pink
    F.BorderSizePixel = 0; F.Parent = Scroll
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 12)
    local s = Instance.new("UIStroke", F); s.Color = DarkPink; s.Thickness = 1.5
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, -20, 0, 22); L.Position = UDim2.new(0, 12, 0, 6)
    L.BackgroundTransparency = 1; L.Text = emoji .. "  " .. name
    L.TextColor3 = Color3.new(1,1,1); L.TextSize = 14
    L.Font = Enum.Font.GothamSemibold; L.TextXAlignment = Enum.TextXAlignment.Left; L.Parent = F
    local V = Instance.new("TextLabel")
    V.Size = UDim2.new(0, 50, 0, 22); V.Position = UDim2.new(1, -60, 0, 6)
    V.BackgroundTransparency = 1; V.Text = tostring(default)
    V.TextColor3 = Color3.new(1,1,1); V.TextSize = 14
    V.Font = Enum.Font.GothamBold; V.TextXAlignment = Enum.TextXAlignment.Right; V.Parent = F
    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -24, 0, 8); Bar.Position = UDim2.new(0, 12, 0, 40)
    Bar.BackgroundColor3 = Color3.new(1,1,1); Bar.BorderSizePixel = 0; Bar.Parent = F
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = DarkPink; Fill.BorderSizePixel = 0; Fill.Parent = Bar
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    local dr = false
    local function upd(x)
        local r = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max-min) * r)
        Fill.Size = UDim2.new(r, 0, 1, 0); V.Text = tostring(val); cb(val)
    end
    Bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dr = true; upd(i.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i.Position.X) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = false end
    end)
    cb(default)
end

------------------------------------------------------------
-- FUNÇÕES
------------------------------------------------------------

-- Speed
local speedV = 16
makeSlider("Speed", "⚡", 16, 200, 16, function(v)
    speedV = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)
LocalPlayer.CharacterAdded:Connect(function(c)
    task.wait(0.5)
    if c:FindFirstChild("Humanoid") then c.Humanoid.WalkSpeed = speedV end
end)

-- Infinite Jump
local infJump = false
makeToggle("Infinite Jump", "🦘", function(on) infJump = on end)
UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character then
        local h = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Noclip
local noclip = false
makeToggle("Noclip", "👻", function(on) noclip = on end)
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Fly
local flyOn, flySpeed = false, 50
local bv, bg, fconn
local function startFly()
    local c = LocalPlayer.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    bv = Instance.new("BodyVelocity"); bv.MaxForce = Vector3.new(1,1,1)*1e5; bv.Velocity = Vector3.zero; bv.Parent = hrp
    bg = Instance.new("BodyGyro"); bg.MaxTorque = Vector3.new(1,1,1)*1e5; bg.P = 1000; bg.D = 100; bg.Parent = hrp
    fconn = RunService.RenderStepped:Connect(function()
        local cam = workspace.CurrentCamera
        local d = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then d += cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then d -= cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then d -= cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then d += cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then d -= Vector3.new(0,1,0) end
        if d.Magnitude > 0 then d = d.Unit end
        bv.Velocity = d * flySpeed
        bg.CFrame = cam.CFrame
    end)
end
local function stopFly()
    if fconn then fconn:Disconnect(); fconn = nil end
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
end
makeToggle("Fly", "🕊️", function(on) flyOn = on; if on then startFly() else stopFly() end end)
LocalPlayer.CharacterAdded:Connect(function()
    if flyOn then task.wait(1); stopFly(); startFly() end
end)

-- Float
local floatOn, floatPart, floatConn = false
local function startFloat()
    local c = LocalPlayer.Character; if not c then return end
    local hrp = c:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    floatPart = Instance.new("Part")
    floatPart.Size = Vector3.new(6, 1, 6); floatPart.Anchored = true; floatPart.CanCollide = true
    floatPart.Material = Enum.Material.Neon; floatPart.Color = Color3.fromRGB(255,105,180)
    floatPart.Transparency = 0.3; floatPart.Parent = workspace
    floatConn = RunService.Heartbeat:Connect(function()
        if floatPart and hrp and hrp.Parent then
            floatPart.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 3.5, 0))
        end
    end)
end
local function stopFloat()
    if floatConn then floatConn:Disconnect(); floatConn = nil end
    if floatPart then floatPart:Destroy(); floatPart = nil end
end
makeToggle("Float", "☁️", function(on) floatOn = on; if on then startFloat() else stopFloat() end end)
LocalPlayer.CharacterAdded:Connect(function()
    if floatOn then task.wait(1); stopFloat(); startFloat() end
end)

-- ESP
local espOn = false
local espObj = {}
local function addESP(p)
    if p == LocalPlayer or espObj[p] then return end
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 100, 0, 50); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.Parent = game.CoreGui
    local l = Instance.new("TextLabel", bb)
    l.Size = UDim2.new(1, 0, 1, 0); l.BackgroundTransparency = 1
    l.Text = "🌸 " .. p.Name .. " 🌸"; l.TextColor3 = Color3.fromRGB(255,105,180)
    l.TextStrokeTransparency = 0; l.TextSize = 14; l.Font = Enum.Font.GothamBold
    local hl = Instance.new("Highlight")
    hl.FillColor = Color3.fromRGB(255,105,180); hl.FillTransparency = 0.6
    hl.OutlineColor = Pink
    if p.Character then hl.Parent = p.Character end
    espObj[p] = {bb = bb, hl = hl}
    local function upd()
        if p.Character and p.Character:FindFirstChild("Head") then
            bb.Adornee = p.Character.Head
            hl.Parent = p.Character
        end
    end
    upd()
    p.CharacterAdded:Connect(function() task.wait(0.5); if espOn then upd() end end)
end
local function remESP(p)
    if espObj[p] then
        if espObj[p].bb then espObj[p].bb:Destroy() end
        if espObj[p].hl then espObj[p].hl:Destroy() end
        espObj[p] = nil
    end
end
makeToggle("ESP", "👁️", function(on)
    espOn = on
    if on then
        for _, p in pairs(Players:GetPlayers()) do addESP(p) end
    else
        for _, p in pairs(Players:GetPlayers()) do remESP(p) end
    end
end)
Players.PlayerAdded:Connect(function(p) if espOn then addESP(p) end end)
Players.PlayerRemoving:Connect(function(p) remESP(p) end)
