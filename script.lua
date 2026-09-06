--[[ DEATH HUB • generated script
     Features: Script
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

local Config = {
    ["Script"] = true,
}

-- intro (blur + flash + sliding word, like the video)
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local function playIntro()
    local topWord = "DEATH"
    local bottomWord = "HUB"

    -- blur the whole game
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = Lighting
    TweenService:Create(blur, TweenInfo.new(0.6), { Size = 24 }):Play()

    local gui = Instance.new("ScreenGui")
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999
    gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

    -- dark tint over the screen
    local tint = Instance.new("Frame", gui)
    tint.Size = UDim2.fromScale(1, 1)
    tint.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tint.BackgroundTransparency = 1
    TweenService:Create(tint, TweenInfo.new(0.6), { BackgroundTransparency = 0.45 }):Play()

    -- white flash layer
    local flash = Instance.new("Frame", gui)
    flash.Size = UDim2.fromScale(1, 1)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BackgroundTransparency = 1
    flash.ZIndex = 5

    local function makeWord(text, yScale, fromX)
        local lbl = Instance.new("TextLabel", gui)
        lbl.Size = UDim2.fromScale(0.9, 0.16)
        lbl.Position = UDim2.fromScale(fromX, yScale)
        lbl.AnchorPoint = Vector2.new(0.5, 0.5)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextScaled = true
        lbl.TextColor3 = Color3.fromRGB(0, 0, 0)
        lbl.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextStrokeTransparency = 0.5
        lbl.TextTransparency = 1
        lbl.Text = text
        lbl.ZIndex = 3
        return lbl
    end

    local top = makeWord(topWord, 0.42, -0.4)
    local bottom = makeWord(bottomWord, 0.58, 1.4)

    local slide = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(top, slide, { Position = UDim2.fromScale(0.5, 0.42), TextTransparency = 0 }):Play()
    task.wait(0.15)
    TweenService:Create(bottom, slide, { Position = UDim2.fromScale(0.5, 0.58), TextTransparency = 0 }):Play()

    -- flashing pulses (runs through the full ~5.4s intro)
    task.spawn(function()
        for i = 1, 14 do
            flash.BackgroundTransparency = 0.65
            TweenService:Create(flash, TweenInfo.new(0.18), { BackgroundTransparency = 1 }):Play()
            top.TextStrokeTransparency = 0
            bottom.TextStrokeTransparency = 0
            task.wait(0.12)
            top.TextStrokeTransparency = 0.6
            bottom.TextStrokeTransparency = 0.6
            task.wait(0.25)
        end
    end)

    -- intro song
    task.spawn(function()
        local ok, data = pcall(function() return game:HttpGet("https://files.catbox.moe/ejdk0u.mp3") end)
        if ok and writefile and getcustomasset then
            writefile("hub_intro.mp3", data)
            local sound = Instance.new("Sound", gui)
            sound.SoundId = getcustomasset("hub_intro.mp3")
            sound.Volume = 1
            sound:Play()
        end
    end)

    task.delay(5.4, function()
        local out = TweenInfo.new(0.8)
        TweenService:Create(top, out, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
        TweenService:Create(bottom, out, { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()
        TweenService:Create(tint, out, { BackgroundTransparency = 1 }):Play()
        TweenService:Create(blur, out, { Size = 0 }):Play()
        task.delay(1, function()
            gui:Destroy()
            blur:Destroy()
        end)
    end)
end

task.spawn(playIntro)

-- Script
if Config["Script"] then
    task.spawn(function()
        while task.wait(0.1) do
            if not LP.Character then continue end
            -- TODO: Script logic
        end
    end)
end

warn("[DEATH HUB] loaded 1 feature(s)")
