-- ══════════════════════════════════════════════════════════════
--  MM2 ULTIMATE v3  —  En Kapsamlı MM2 Script
--  loadstring(game:HttpGet("RAW_LINK"))()
--  INSERT = Menü · DELETE = Panic · END = Watermark · HOME = Küçült
-- ══════════════════════════════════════════════════════════════

pcall(function() if _G.__MM2_Destroy then _G.__MM2_Destroy() end end)

local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Lighting          = game:GetService("Lighting")
local Workspace         = game:GetService("Workspace")
local Stats             = game:GetService("Stats")
local LocalPlayer       = Players.LocalPlayer
local Camera            = Workspace.CurrentCamera

-- ══════════════════════════════════════════════════════════════
--  TEMA
-- ══════════════════════════════════════════════════════════════
local T = {
    BG        = Color3.fromRGB(10,10,13),
    Surface   = Color3.fromRGB(18,18,22),
    SurfaceHi = Color3.fromRGB(26,26,32),
    Accent    = Color3.fromRGB(214,40,56),
    AccentDrk = Color3.fromRGB(140,20,35),
    Text      = Color3.fromRGB(240,240,245),
    Dim       = Color3.fromRGB(140,140,150),
    Faint     = Color3.fromRGB(80,80,90),
    Good      = Color3.fromRGB(72,199,116),
    Warn      = Color3.fromRGB(232,172,62),
    Bad       = Color3.fromRGB(226,72,72),
    Border    = Color3.fromRGB(35,35,42),
    Murd      = Color3.fromRGB(255,60,60),
    Sher      = Color3.fromRGB(255,200,50),
    Inno      = Color3.fromRGB(80,160,255),
}

-- ══════════════════════════════════════════════════════════════
--  YARDIMCI FONKSİYONLAR
-- ══════════════════════════════════════════════════════════════
local function tw(i,p,t,s,d)
    local tween = TweenService:Create(i, TweenInfo.new(t or 0.25, s or Enum.EasingStyle.Quint, d or Enum.EasingDirection.Out), p)
    tween:Play() return tween
end

local function corner(i,r)
    local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=i return c
end

local function stroke(i,c,t,tr)
    local s=Instance.new("UIStroke") s.Color=c or T.Border s.Thickness=t or 1 s.Transparency=tr or 0
    s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=i return s
end

local function grad(i,c1,c2,rot)
    local g=Instance.new("UIGradient")
    g.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,c1),ColorSequenceKeypoint.new(1,c2)})
    g.Rotation=rot or 0 g.Parent=i return g
end

local function lbl(p,txt,sz,col,fnt,xa,pos,s2)
    local l=Instance.new("TextLabel") l.Parent=p l.BackgroundTransparency=1 l.Text=txt or ""
    l.TextSize=sz or 13 l.TextColor3=col or T.Text l.Font=fnt or Enum.Font.Gotham
    l.TextXAlignment=xa or Enum.TextXAlignment.Left l.Position=pos or UDim2.new(0,0,0,0)
    l.Size=s2 or UDim2.new(1,0,1,0) l.TextTruncate=Enum.TextTruncate.AtEnd return l
end

local function shade(c,mult)
    local h,s,v=Color3.toHSV(c) return Color3.fromHSV(h,s,math.clamp(v*mult,0,1))
end

local function mount(g)
    local ok=pcall(function()
        if typeof(gethui)=="function" then g.Parent=gethui()
        else g.Parent=game:GetService("CoreGui") end
    end)
    if not ok or not g.Parent then g.Parent=LocalPlayer:WaitForChild("PlayerGui") end
    return g
end

local function clearOld(n)
    for _,p in ipairs({LocalPlayer:FindFirstChild("PlayerGui"),game:FindFirstChild("CoreGui")}) do
        if p then pcall(function() local o=p:FindFirstChild(n) if o then o:Destroy() end end) end
    end
    pcall(function() if typeof(gethui)=="function" then local o=gethui():FindFirstChild(n) if o then o:Destroy() end end end)
end

for _,n in ipairs({"MM2Ultimate","MM2Notify","MM2Visuals","MM2Radar","MM2Watermark","MM2Keybind"}) do clearOld(n) end

-- ══════════════════════════════════════════════════════════════
--  WATERMARK
-- ══════════════════════════════════════════════════════════════
local WM=mount(Instance.new("ScreenGui"))
WM.Name="MM2Watermark" WM.ResetOnSpawn=false WM.DisplayOrder=996
local wmFrame=Instance.new("Frame") wmFrame.Size=UDim2.new(0,240,0,34) wmFrame.Position=UDim2.new(0,10,0,10) wmFrame.BackgroundColor3=T.Surface wmFrame.BackgroundTransparency=0.05 wmFrame.BorderSizePixel=0 wmFrame.Parent=WM corner(wmFrame,8) stroke(wmFrame,T.Accent,1,0.3)
grad(wmFrame, shade(T.Accent,0.35), T.Surface, 25)
local wmBar=Instance.new("Frame") wmBar.Size=UDim2.new(0,3,1,-10) wmBar.Position=UDim2.new(0,0,0,5) wmBar.BackgroundColor3=T.Accent wmBar.BorderSizePixel=0 wmBar.Parent=wmFrame corner(wmBar,2)
lbl(wmFrame,"🔪 MM2 Ultimate",12,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,12,0,0),UDim2.new(0.55,0,1,0))
local wmInfo=lbl(wmFrame,"",10,T.Sher,Enum.Font.GothamBold,Enum.TextXAlignment.Right,UDim2.new(0.55,0,0,0),UDim2.new(0.45,-10,1,0))

-- ══════════════════════════════════════════════════════════════
--  BİLDİRİM SİSTEMİ
-- ══════════════════════════════════════════════════════════════
local NotifyGui=mount(Instance.new("ScreenGui"))
NotifyGui.Name="MM2Notify" NotifyGui.ResetOnSpawn=false NotifyGui.DisplayOrder=1001
local NH=Instance.new("Frame") NH.Size=UDim2.new(0,310,1,-20) NH.Position=UDim2.new(1,-324,0,10) NH.BackgroundTransparency=1 NH.Parent=NotifyGui
local NL=Instance.new("UIListLayout") NL.Padding=UDim.new(0,8) NL.SortOrder=Enum.SortOrder.LayoutOrder NL.VerticalAlignment=Enum.VerticalAlignment.Top NL.HorizontalAlignment=Enum.HorizontalAlignment.Right NL.Parent=NH
local nC=0

local function notify(title,text,kind,dur)
    nC=nC+1
    local col=kind=="success" and T.Good or kind=="warn" and T.Warn or kind=="error" and T.Bad or T.Accent
    local glyph=kind=="success" and "✓" or kind=="warn" and "!" or kind=="error" and "✕" or "i"
    dur=dur or 4
    local outer=Instance.new("Frame") outer.Size=UDim2.new(1,0,0,0) outer.BackgroundTransparency=1 outer.LayoutOrder=nC outer.Parent=NH
    local card=Instance.new("Frame") card.Size=UDim2.new(1,0,0,text~="" and 64 or 42) card.Position=UDim2.new(1.3,0,0,0) card.BackgroundColor3=T.Surface card.BorderSizePixel=0 card.Parent=outer corner(card,10) stroke(card,T.Border,1,0.2)
    local bar=Instance.new("Frame") bar.Size=UDim2.new(0,3,1,-16) bar.Position=UDim2.new(0,0,0,8) bar.BackgroundColor3=col bar.BorderSizePixel=0 bar.Parent=card corner(bar,2)
    local gi=Instance.new("Frame") gi.Size=UDim2.new(0,28,0,28) gi.Position=UDim2.new(0,12,0,8) gi.BackgroundColor3=col gi.BackgroundTransparency=0.8 gi.BorderSizePixel=0 gi.Parent=card corner(gi,7)
    lbl(gi,glyph,15,col,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
    lbl(card,title,13,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,48,0,text~="" and 9 or 0),UDim2.new(1,-60,0,text~="" and 16 or 42))
    if text~="" then lbl(card,text,11,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,48,0,28),UDim2.new(1,-60,0,30)) end
    local prog=Instance.new("Frame") prog.Size=UDim2.new(1,0,0,2) prog.AnchorPoint=Vector2.new(0,1) prog.Position=UDim2.new(0,0,1,0) prog.BackgroundColor3=col prog.BorderSizePixel=0 prog.Parent=card corner(prog,1)
    tw(outer,{Size=UDim2.new(1,0,0,(text~="" and 64 or 42)+6)},0.5)
    tw(card,{Position=UDim2.new(0,0,0,0)},0.6,Enum.EasingStyle.Back)
    TweenService:Create(prog,TweenInfo.new(dur,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,2)}):Play()
    local dismissed=false
    local function dismiss()
        if dismissed then return end dismissed=true
        tw(card,{Position=UDim2.new(1.3,0,0,0)},0.4) tw(outer,{Size=UDim2.new(1,0,0,0)},0.4)
        task.delay(0.5,function() if outer then outer:Destroy() end end)
    end
    local cb=Instance.new("TextButton") cb.Size=UDim2.new(1,0,1,0) cb.BackgroundTransparency=1 cb.Text="" cb.Parent=card cb.MouseButton1Click:Connect(dismiss)
    task.delay(dur,dismiss)
end

-- ══════════════════════════════════════════════════════════════
--  RADAR
-- ══════════════════════════════════════════════════════════════
local RadarGui=mount(Instance.new("ScreenGui"))
RadarGui.Name="MM2Radar" RadarGui.ResetOnSpawn=false RadarGui.DisplayOrder=997
local RadarFrame=Instance.new("Frame")
RadarFrame.Size=UDim2.new(0,190,0,190) RadarFrame.Position=UDim2.new(1,-204,1,-204)
RadarFrame.BackgroundColor3=Color3.fromRGB(10,10,13) RadarFrame.BackgroundTransparency=0.15
RadarFrame.BorderSizePixel=0 RadarFrame.Visible=false RadarFrame.Parent=RadarGui
corner(RadarFrame,95) stroke(RadarFrame,T.Accent,2,0.1)
lbl(RadarFrame,"📡 RADAR",11,T.Accent,Enum.Font.GothamBold,Enum.TextXAlignment.Center,UDim2.new(0,0,0,-24),UDim2.new(1,0,0,20))

for _,h in ipairs({true,false}) do
    local f=Instance.new("Frame") f.BackgroundColor3=Color3.fromRGB(35,35,45) f.BackgroundTransparency=0.3 f.BorderSizePixel=0
    if h then f.Size=UDim2.new(1,0,0,1) f.Position=UDim2.new(0,0,0.5,0) else f.Size=UDim2.new(0,1,1,0) f.Position=UDim2.new(0.5,0,0,0) end
    f.Parent=RadarFrame
end
-- İç halka
local innerRing=Instance.new("Frame") innerRing.Size=UDim2.new(0,95,0,95) innerRing.AnchorPoint=Vector2.new(0.5,0.5) innerRing.Position=UDim2.new(0.5,0,0.5,0) innerRing.BackgroundTransparency=1 innerRing.BorderSizePixel=0 innerRing.Parent=RadarFrame corner(innerRing,48) stroke(innerRing,Color3.fromRGB(35,35,45),1,0.4)

local RadarCenter=Instance.new("Frame") RadarCenter.Size=UDim2.new(0,8,0,8) RadarCenter.AnchorPoint=Vector2.new(0.5,0.5) RadarCenter.Position=UDim2.new(0.5,0,0.5,0) RadarCenter.BackgroundColor3=T.Good RadarCenter.BorderSizePixel=0 RadarCenter.ZIndex=3 RadarCenter.Parent=RadarFrame corner(RadarCenter,4) stroke(RadarCenter,T.Text,1)

local SheriffDropMarker=Instance.new("Frame") SheriffDropMarker.Size=UDim2.new(0,16,0,16) SheriffDropMarker.AnchorPoint=Vector2.new(0.5,0.5) SheriffDropMarker.BackgroundColor3=T.Sher SheriffDropMarker.BorderSizePixel=0 SheriffDropMarker.ZIndex=4 SheriffDropMarker.Visible=false SheriffDropMarker.Parent=RadarFrame corner(SheriffDropMarker,3)
lbl(SheriffDropMarker,"🔫",11,Color3.fromRGB(0,0,0),Enum.Font.GothamBold,Enum.TextXAlignment.Center)
local SheriffDropLabel=Instance.new("TextLabel") SheriffDropLabel.Size=UDim2.new(0,90,0,16) SheriffDropLabel.AnchorPoint=Vector2.new(0.5,0) SheriffDropLabel.BackgroundColor3=Color3.fromRGB(10,10,13) SheriffDropLabel.BackgroundTransparency=0.2 SheriffDropLabel.BorderSizePixel=0 SheriffDropLabel.Text="" SheriffDropLabel.TextColor3=T.Sher SheriffDropLabel.Font=Enum.Font.GothamBold SheriffDropLabel.TextSize=9 SheriffDropLabel.ZIndex=5 SheriffDropLabel.Visible=false SheriffDropLabel.Parent=RadarFrame corner(SheriffDropLabel,4)

local radarDots={}
local function getDot(name)
    if not radarDots[name] then
        local dot=Instance.new("Frame") dot.Size=UDim2.new(0,11,0,11) dot.AnchorPoint=Vector2.new(0.5,0.5) dot.BorderSizePixel=0 dot.ZIndex=2 dot.Parent=RadarFrame corner(dot,6) stroke(dot,Color3.fromRGB(0,0,0),1,0.3)
        local dtxt=Instance.new("TextLabel") dtxt.Size=UDim2.new(0,60,0,12) dtxt.AnchorPoint=Vector2.new(0.5,1) dtxt.Position=UDim2.new(0.5,0,0,-1) dtxt.BackgroundTransparency=1 dtxt.Font=Enum.Font.GothamBold dtxt.TextSize=8 dtxt.ZIndex=3 dtxt.Parent=dot
        radarDots[name]={dot=dot,txt=dtxt}
    end
    return radarDots[name]
end

local sheriffDropPos=nil
local lastSheriffName=nil
local RADAR_RANGE=150

local function worldToRadar(wp)
    local mc=LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart")
    if not mr then return nil end
    local diff=wp-mr.Position
    local x=diff:Dot(mr.CFrame.RightVector) local z=diff:Dot(mr.CFrame.LookVector)
    return math.clamp(x/RADAR_RANGE,-1,1)*0.45+0.5, math.clamp(-z/RADAR_RANGE,-1,1)*0.45+0.5
end

-- ══════════════════════════════════════════════════════════════
--  ANA PENCERE
-- ══════════════════════════════════════════════════════════════
local GUI=mount(Instance.new("ScreenGui"))
GUI.Name="MM2Ultimate" GUI.ResetOnSpawn=false GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling GUI.DisplayOrder=999

-- ══════════════════════════════════════════════════════════════
--  PENCERE BOYUTU — ekrana göre otomatik, ASLA taşmaz
-- ══════════════════════════════════════════════════════════════
local screenSize = Camera.ViewportSize
-- Ekranın en fazla %90'ını kapla, güvenli kenar boşluğu bırak
local WIN_W = math.floor(math.min(600, screenSize.X * 0.92))
local WIN_H = math.floor(math.min(560, screenSize.Y * 0.88))

local GlowGui=Instance.new("Frame") GlowGui.Size=UDim2.new(0,WIN_W+30,0,WIN_H+30) GlowGui.Position=UDim2.new(0.5,-(WIN_W+30)/2,0.5,-(WIN_H+30)/2) GlowGui.BackgroundTransparency=1 GlowGui.ZIndex=0 GlowGui.Parent=GUI
local GlowImg=Instance.new("ImageLabel") GlowImg.Size=UDim2.new(1,60,1,60) GlowImg.Position=UDim2.new(0,-30,0,-30) GlowImg.BackgroundTransparency=1 GlowImg.Image="rbxassetid://5028857084" GlowImg.ImageColor3=T.Accent GlowImg.ImageTransparency=0.85 GlowImg.ScaleType=Enum.ScaleType.Slice GlowImg.SliceCenter=Rect.new(24,24,276,276) GlowImg.ZIndex=0 GlowImg.Parent=GlowGui

local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,WIN_W,0,WIN_H) Main.Position=UDim2.new(0.5,-WIN_W/2,0.5,-WIN_H/2)
Main.BackgroundColor3=T.BG Main.BorderSizePixel=0 Main.Active=true
Main.Visible=false Main.ZIndex=1 Main.Parent=GUI
corner(Main,12) stroke(Main,T.Border,1)

-- Başlık çubuğu
local TitleBar=Instance.new("Frame") TitleBar.Size=UDim2.new(1,0,0,54) TitleBar.BackgroundColor3=T.Surface TitleBar.BorderSizePixel=0 TitleBar.ZIndex=2 TitleBar.Parent=Main corner(TitleBar,12)
local TFix=Instance.new("Frame") TFix.Size=UDim2.new(1,0,0.5,0) TFix.Position=UDim2.new(0,0,0.5,0) TFix.BackgroundColor3=T.Surface TFix.BorderSizePixel=0 TFix.Parent=TitleBar
grad(TitleBar, Color3.fromRGB(95,16,22), T.Surface, 0)
local TU=Instance.new("Frame") TU.Size=UDim2.new(1,0,0,2) TU.Position=UDim2.new(0,0,1,-2) TU.BackgroundColor3=T.Accent TU.BorderSizePixel=0 TU.Parent=TitleBar
local TM=Instance.new("Frame") TM.Size=UDim2.new(0,4,0,22) TM.Position=UDim2.new(0,14,0.5,-11) TM.BackgroundColor3=T.Accent TM.BorderSizePixel=0 TM.Parent=TitleBar corner(TM,2)
lbl(TitleBar,"🔪  MM2 Ultimate",16,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,26,0,9),UDim2.new(0.7,0,0,20))
lbl(TitleBar,"v3  ·  INSERT menü · DELETE panic · END watermark",10,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,26,0,31),UDim2.new(0.7,0,0,14))

local function titleBtn(x,txt,col,cb)
    local b=Instance.new("TextButton") b.Size=UDim2.new(0,28,0,28) b.Position=UDim2.new(1,x,0.5,-14) b.BackgroundColor3=col b.BackgroundTransparency=0.5 b.Text=txt b.TextColor3=T.Text b.Font=Enum.Font.GothamBold b.TextSize=14 b.BorderSizePixel=0 b.AutoButtonColor=false b.Parent=TitleBar corner(b,7)
    b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0}) end)
    b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0.5}) end)
    b.MouseButton1Click:Connect(cb) return b
end
titleBtn(-38,"✕",T.Bad,function() Main.Visible=false GlowGui.Visible=false end)
local minimized=false
local ContentWrapper=Instance.new("Frame") ContentWrapper.Size=UDim2.new(1,0,1,-54-28) ContentWrapper.Position=UDim2.new(0,0,0,54) ContentWrapper.BackgroundTransparency=1 ContentWrapper.ClipsDescendants=true ContentWrapper.Parent=Main

-- Küçültme fonksiyonu (hem buton hem HOME tuşu kullanır)
local doMinimize
titleBtn(-72,"—",T.Warn,function() doMinimize() end)

-- ══════════════════════════════════════════════════════════════
--  SINIRLI SÜRÜKLEME — pencere ekran dışına ÇIKAMAZ
-- ══════════════════════════════════════════════════════════════
do
    local dragging=false
    local dragStart=nil
    local startPos=nil

    local function clampToScreen(pos)
        local vs=Camera.ViewportSize
        local w=Main.AbsoluteSize.X
        local h=Main.AbsoluteSize.Y
        -- Piksel cinsinden mutlak konum hesapla
        local absX=pos.X.Scale*vs.X+pos.X.Offset
        local absY=pos.Y.Scale*vs.Y+pos.Y.Offset
        -- Ekran içinde tut (en az 40px görünür kalsın)
        absX=math.clamp(absX,0,math.max(0,vs.X-w))
        absY=math.clamp(absY,0,math.max(0,vs.Y-h))
        return UDim2.new(0,absX,0,absY)
    end

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            dragging=true
            dragStart=input.Position
            startPos=Main.Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then dragging=false end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
            local delta=input.Position-dragStart
            local newPos=UDim2.new(
                startPos.X.Scale, startPos.X.Offset+delta.X,
                startPos.Y.Scale, startPos.Y.Offset+delta.Y
            )
            Main.Position=clampToScreen(newPos)
        end
    end)
end

-- Tab bar
local TabBar=Instance.new("Frame") TabBar.Size=UDim2.new(1,0,0,46) TabBar.BackgroundColor3=Color3.fromRGB(14,14,17) TabBar.BorderSizePixel=0 TabBar.Parent=ContentWrapper
local TBL=Instance.new("UIListLayout") TBL.FillDirection=Enum.FillDirection.Horizontal TBL.Padding=UDim.new(0,2) TBL.VerticalAlignment=Enum.VerticalAlignment.Center TBL.HorizontalAlignment=Enum.HorizontalAlignment.Center TBL.Parent=TabBar
local TBP=Instance.new("UIPadding") TBP.PaddingTop=UDim.new(0,4) TBP.PaddingBottom=UDim.new(0,4) TBP.PaddingLeft=UDim.new(0,4) TBP.PaddingRight=UDim.new(0,4) TBP.Parent=TabBar
local TBUnder=Instance.new("Frame") TBUnder.Size=UDim2.new(1,0,0,1) TBUnder.Position=UDim2.new(0,0,1,-1) TBUnder.BackgroundColor3=T.Border TBUnder.BorderSizePixel=0 TBUnder.Parent=TabBar

local ContentArea=Instance.new("Frame") ContentArea.Size=UDim2.new(1,0,1,-46) ContentArea.Position=UDim2.new(0,0,0,46) ContentArea.BackgroundTransparency=1 ContentArea.ClipsDescendants=true ContentArea.Parent=ContentWrapper

-- Status bar
local StatusBar=Instance.new("Frame") StatusBar.Size=UDim2.new(1,0,0,28) StatusBar.AnchorPoint=Vector2.new(0,1) StatusBar.Position=UDim2.new(0,0,1,0) StatusBar.BackgroundColor3=Color3.fromRGB(14,14,17) StatusBar.BorderSizePixel=0 StatusBar.ZIndex=5 StatusBar.Parent=Main
local SBL=Instance.new("Frame") SBL.Size=UDim2.new(1,0,0,1) SBL.BackgroundColor3=T.Border SBL.BorderSizePixel=0 SBL.Parent=StatusBar
local SDot=Instance.new("Frame") SDot.Size=UDim2.new(0,6,0,6) SDot.Position=UDim2.new(0,12,0.5,-3) SDot.BackgroundColor3=T.Good SDot.BorderSizePixel=0 SDot.Parent=StatusBar corner(SDot,3)
local STxt=lbl(StatusBar,"Hazır",11,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,26,0,0),UDim2.new(0.55,0,1,0))
local SRight=lbl(StatusBar,"",11,T.Faint,Enum.Font.GothamMedium,Enum.TextXAlignment.Right,UDim2.new(0.45,0,0,0),UDim2.new(0.55,-12,1,0))
local function setStatus(txt,kind) STxt.Text=txt local col=kind=="ok" and T.Good or kind=="warn" and T.Warn or kind=="error" and T.Bad or T.Faint tw(SDot,{BackgroundColor3=col}) end

-- Küçültme: içerik + status bar gizlenir, glow da küçülür
doMinimize=function()
    minimized=not minimized
    local targetH = minimized and 54 or WIN_H
    tw(Main,{Size=UDim2.new(0,WIN_W,0,targetH)},0.35,Enum.EasingStyle.Quint)
    -- Status bar küçükken görünmesin
    StatusBar.Visible = not minimized
    -- Glow da küçülsün (arkada kırmızı iz kalmasın)
    tw(GlowGui,{Size=UDim2.new(0,WIN_W+30,0,targetH+30)},0.35,Enum.EasingStyle.Quint)
end

-- ══════════════════════════════════════════════════════════════
--  TAB & KONTROL ÜRETİCİLER
-- ══════════════════════════════════════════════════════════════
local tabs={} local activeTab=nil
local function makeTab(name,icon)
    -- Tab genişliği ORANSAL: her tab pencerenin tam 1/7'si → asla taşmaz
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1/7,-3,1,0) btn.BackgroundColor3=T.Surface btn.BackgroundTransparency=1 btn.Text=icon.."\n"..name btn.TextColor3=T.Faint btn.Font=Enum.Font.GothamMedium btn.TextSize=10 btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.TextWrapped=true btn.Parent=TabBar corner(btn,6)
    local ind=Instance.new("Frame") ind.Size=UDim2.new(0,0,0,2) ind.AnchorPoint=Vector2.new(0.5,1) ind.Position=UDim2.new(0.5,0,1,0) ind.BackgroundColor3=T.Accent ind.BorderSizePixel=0 ind.Parent=btn corner(ind,1)
    local scroll=Instance.new("ScrollingFrame") scroll.Size=UDim2.new(1,0,1,0) scroll.BackgroundTransparency=1 scroll.BorderSizePixel=0 scroll.CanvasSize=UDim2.new() scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y scroll.ScrollBarThickness=3 scroll.ScrollBarImageColor3=T.Accent scroll.Visible=false scroll.Parent=ContentArea
    local sl=Instance.new("UIListLayout") sl.Padding=UDim.new(0,8) sl.Parent=scroll
    local sp=Instance.new("UIPadding") sp.PaddingLeft=UDim.new(0,12) sp.PaddingRight=UDim.new(0,12) sp.PaddingTop=UDim.new(0,12) sp.PaddingBottom=UDim.new(0,12) sp.Parent=scroll
    local tab={btn=btn,scroll=scroll,ind=ind}
    btn.MouseEnter:Connect(function() if activeTab~=tab then tw(btn,{TextColor3=T.Dim,BackgroundTransparency=0.7}) end end)
    btn.MouseLeave:Connect(function() if activeTab~=tab then tw(btn,{TextColor3=T.Faint,BackgroundTransparency=1}) end end)
    btn.MouseButton1Click:Connect(function()
        if activeTab then activeTab.scroll.Visible=false tw(activeTab.btn,{TextColor3=T.Faint,BackgroundTransparency=1}) tw(activeTab.ind,{Size=UDim2.new(0,0,0,2)},0.3) end
        activeTab=tab scroll.Visible=true tw(btn,{TextColor3=T.Text,BackgroundTransparency=0.5}) tw(ind,{Size=UDim2.new(1,-16,0,2)},0.3,Enum.EasingStyle.Back)
    end)
    tabs[name]=tab
    if not activeTab then activeTab=tab scroll.Visible=true btn.TextColor3=T.Text btn.BackgroundTransparency=0.5 ind.Size=UDim2.new(1,-16,0,2) end
    return tab
end

local function makeSection(tab,title,icon)
    local card=Instance.new("Frame") card.Size=UDim2.new(1,0,0,0) card.AutomaticSize=Enum.AutomaticSize.Y card.BackgroundColor3=T.Surface card.BorderSizePixel=0 card.Parent=tab.scroll corner(card,10) stroke(card,T.Border,1,0.3)
    local cl=Instance.new("UIListLayout") cl.Padding=UDim.new(0,5) cl.Parent=card
    local cp=Instance.new("UIPadding") cp.PaddingLeft=UDim.new(0,10) cp.PaddingRight=UDim.new(0,10) cp.PaddingTop=UDim.new(0,10) cp.PaddingBottom=UDim.new(0,10) cp.Parent=card
    local hdr=Instance.new("Frame") hdr.Size=UDim2.new(1,0,0,24) hdr.BackgroundTransparency=1 hdr.Parent=card
    local mark=Instance.new("Frame") mark.Size=UDim2.new(0,3,0,16) mark.Position=UDim2.new(0,0,0.5,-8) mark.BackgroundColor3=T.Accent mark.BorderSizePixel=0 mark.Parent=hdr corner(mark,2)
    lbl(hdr,(icon or "").."  "..title:upper(),11,T.Accent,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,10,0,0),UDim2.new(1,-10,1,0))
    local div=Instance.new("Frame") div.Size=UDim2.new(1,0,0,1) div.BackgroundColor3=T.Border div.BackgroundTransparency=0.4 div.BorderSizePixel=0 div.Parent=card
    return card
end

local function makeToggle(parent,name,desc,callback)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,desc and 48 or 38) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    local sidebar=Instance.new("Frame") sidebar.Size=UDim2.new(0,3,1,-10) sidebar.Position=UDim2.new(0,0,0,5) sidebar.BackgroundColor3=T.Accent sidebar.BackgroundTransparency=1 sidebar.BorderSizePixel=0 sidebar.Parent=row corner(sidebar,2)
    lbl(row,name,13,T.Text,Enum.Font.GothamMedium,Enum.TextXAlignment.Left,UDim2.new(0,12,0,desc and 6 or 0),UDim2.new(0.75,0,0,desc and 18 or 38))
    if desc then lbl(row,desc,10,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,12,0,25),UDim2.new(0.75,0,0,14)) end
    local track=Instance.new("Frame") track.Size=UDim2.new(0,42,0,22) track.Position=UDim2.new(1,-52,0.5,-11) track.BackgroundColor3=Color3.fromRGB(45,45,52) track.BorderSizePixel=0 track.Parent=row corner(track,11)
    local knob=Instance.new("Frame") knob.Size=UDim2.new(0,16,0,16) knob.Position=UDim2.new(0,3,0.5,-8) knob.BackgroundColor3=T.Dim knob.BorderSizePixel=0 knob.Parent=track corner(knob,8)
    local on=false
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,1,0) btn.BackgroundTransparency=1 btn.Text="" btn.Parent=row
    local h={}
    function h:get() return on end
    function h:set(v,fire)
        on=v
        tw(track,{BackgroundColor3=on and T.Accent or Color3.fromRGB(45,45,52)})
        tw(knob,{Position=on and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),BackgroundColor3=on and T.Text or T.Dim},0.25,Enum.EasingStyle.Back)
        tw(sidebar,{BackgroundTransparency=on and 0 or 1})
        if fire~=false then pcall(callback,on) end
    end
    row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=T.SurfaceHi}) end)
    row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=T.BG}) end)
    btn.MouseButton1Click:Connect(function() h:set(not on) end)
    return h
end

local function makeButton(parent,name,col,cb)
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,0,36) btn.BackgroundColor3=col or T.AccentDrk btn.Text=name btn.TextColor3=T.Text btn.Font=Enum.Font.GothamMedium btn.TextSize=13 btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.Parent=parent corner(btn,8) stroke(btn,col or T.Accent,1,0.5)
    local bc=col or T.AccentDrk
    btn.MouseEnter:Connect(function() tw(btn,{BackgroundColor3=T.Accent}) end)
    btn.MouseLeave:Connect(function() tw(btn,{BackgroundColor3=bc}) end)
    btn.MouseButton1Down:Connect(function() tw(btn,{BackgroundColor3=Color3.fromRGB(80,0,0)},0.1) end)
    btn.MouseButton1Up:Connect(function() tw(btn,{BackgroundColor3=T.Accent}) end)
    btn.MouseButton1Click:Connect(function() pcall(cb) end)
    return btn
end

local function makeSlider(parent,name,min,max,default,suffix,callback)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,52) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    lbl(row,name,13,T.Text,Enum.Font.GothamMedium,Enum.TextXAlignment.Left,UDim2.new(0,12,0,8),UDim2.new(0.7,0,0,16))
    local vl=lbl(row,tostring(default)..(suffix or ""),12,T.Accent,Enum.Font.GothamBold,Enum.TextXAlignment.Right,UDim2.new(0.65,0,0,8),UDim2.new(0.35,-12,0,16))
    local track=Instance.new("Frame") track.Size=UDim2.new(1,-24,0,6) track.Position=UDim2.new(0,12,0,36) track.BackgroundColor3=Color3.fromRGB(35,35,42) track.BorderSizePixel=0 track.Parent=row corner(track,3)
    local fill=Instance.new("Frame") fill.BackgroundColor3=T.Accent fill.BorderSizePixel=0 fill.Size=UDim2.new((default-min)/(max-min),0,1,0) fill.Parent=track corner(fill,3)
    local knob=Instance.new("Frame") knob.Size=UDim2.new(0,14,0,14) knob.AnchorPoint=Vector2.new(0.5,0.5) knob.Position=UDim2.new((default-min)/(max-min),0,0.5,0) knob.BackgroundColor3=T.Text knob.BorderSizePixel=0 knob.ZIndex=3 knob.Parent=track corner(knob,7) stroke(knob,T.Accent,2)
    local value=default local grabbing=false
    local function setFromX(x)
        local alpha=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
        value=math.floor(min+(max-min)*alpha+0.5) vl.Text=tostring(value)..(suffix or "")
        tw(fill,{Size=UDim2.new(alpha,0,1,0)},0.08) tw(knob,{Position=UDim2.new(alpha,0,0.5,0)},0.08) pcall(callback,value)
    end
    local hit=Instance.new("TextButton") hit.Size=UDim2.new(1,0,0,24) hit.Position=UDim2.new(0,0,0,27) hit.BackgroundTransparency=1 hit.Text="" hit.Parent=row
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then grabbing=true tw(knob,{Size=UDim2.new(0,17,0,17)}) setFromX(i.Position.X) end end)
    UserInputService.InputChanged:Connect(function(i) if grabbing and i.UserInputType==Enum.UserInputType.MouseMovement then setFromX(i.Position.X) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 and grabbing then grabbing=false tw(knob,{Size=UDim2.new(0,14,0,14)}) end end)
    row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=T.SurfaceHi}) end)
    row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=T.BG}) end)
    return{get=function() return value end,set=function(_,v) value=math.clamp(v,min,max) local a=(value-min)/(max-min) vl.Text=tostring(value)..(suffix or "") fill.Size=UDim2.new(a,0,1,0) knob.Position=UDim2.new(a,0,0.5,0) end}
end

local function makeLiveLabel(parent,text,valueText,valueColor)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,32) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    lbl(row,text,12,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,12,0,0),UDim2.new(0.5,0,1,0))
    local val=lbl(row,valueText or "—",12,valueColor or T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Right,UDim2.new(0.5,0,0,0),UDim2.new(0.5,-12,1,0))
    return{set=function(txt,col) val.Text=tostring(txt) if col then val.TextColor3=col end end}
end

-- ══════════════════════════════════════════════════════════════
--  ROL TESPİT (MM2'ye özel)
-- ══════════════════════════════════════════════════════════════
local function checkToolName(tn)
    tn=tn:lower()
    if tn=="knife" or tn:find("knife") or tn:find("blade") or tn:find("murder") or tn:find("sword") or tn:find("scythe") or tn:find("dagger") then return "murderer" end
    if tn=="gun" or tn:find("gun") or tn:find("sheriff") or tn:find("revolver") or tn:find("pistol") or tn:find("hero") then return "sheriff" end
    return nil
end

local function getPlayerRole(player)
    if not player or not player.Character then return "innocent" end
    -- Elindeki tool
    local at=player.Character:FindFirstChildWhichIsA("Tool")
    if at then local r=checkToolName(at.Name) if r then return r end end
    -- Backpack (MM2 için en güvenilir)
    local bp=player:FindFirstChild("Backpack")
    if bp then
        for _,item in pairs(bp:GetChildren()) do
            if item:IsA("Tool") then local r=checkToolName(item.Name) if r then return r end end
        end
    end
    -- leaderstats
    local ls=player:FindFirstChild("leaderstats") or player:FindFirstChild("GameStats")
    if ls then
        local role=ls:FindFirstChild("Role") or ls:FindFirstChild("Team") or ls:FindFirstChild("Status")
        if role then
            local rv=tostring(role.Value):lower()
            if rv:find("murd") or rv:find("killer") then return "murderer"
            elseif rv:find("sheriff") or rv:find("hero") then return "sheriff" end
        end
    end
    -- Character içi
    for _,obj in pairs(player.Character:GetDescendants()) do
        if obj:IsA("Tool") or obj:IsA("Model") then local r=checkToolName(obj.Name) if r then return r end end
    end
    return "innocent"
end

local function roleColor(role,isDead)
    if isDead then return T.Faint end
    return role=="murderer" and T.Murd or role=="sheriff" and T.Sher or T.Inno
end
local function roleText(role,isDead)
    if isDead then return "💀 ÖLÜ" end
    return role=="murderer" and "🔪 KATİL" or role=="sheriff" and "🔫 ŞERİF" or "👤 MASUM"
end

-- ══════════════════════════════════════════════════════════════
--  TABLARI OLUŞTUR (8 tab)
-- ══════════════════════════════════════════════════════════════
local tInfo = makeTab("Bilgi","📊")
local tESP  = makeTab("ESP","👁")
local tAim  = makeTab("Aim","🎯")
local tMove = makeTab("Hareket","🏃")
local tWeap = makeTab("Silah","⚔️")
local tGame = makeTab("Oyun","🎮")
local tFun  = makeTab("Eğlence","🎉")

-- ═══ BİLGİ TABU ═══
local secRoles=makeSection(tInfo,"Rol Bilgisi","🎭")
local lblMurd=makeLiveLabel(secRoles,"🔪 Katil","Tespit ediliyor...",T.Murd)
local lblSher=makeLiveLabel(secRoles,"🔫 Şerif","Tespit ediliyor...",T.Sher)
local lblMyRole=makeLiveLabel(secRoles,"👤 Senin Rolün","?",T.Text)
local lblSherDrop=makeLiveLabel(secRoles,"📍 Şerif Silah Yeri","Henüz düşmedi",T.Sher)

local secStats=makeSection(tInfo,"İstatistikler","📈")
local lblPlayers=makeLiveLabel(secStats,"Oyuncu Sayısı","0")
local lblAlive=makeLiveLabel(secStats,"Hayatta","0",T.Good)
local lblDead=makeLiveLabel(secStats,"Ölü","0",T.Bad)
local lblPing=makeLiveLabel(secStats,"Ping","?")
local lblFPS=makeLiveLabel(secStats,"FPS","?")
local lblRound=makeLiveLabel(secStats,"Round Süresi","0:00")

local secRadarCtrl=makeSection(tInfo,"Radar","📡")
local radarTog=makeToggle(secRadarCtrl,"Radar Göster","Sağ altta mini harita")
local radarRange=makeSlider(secRadarCtrl,"Menzil",50,400,150," st",function(v) RADAR_RANGE=v end)
makeButton(secRadarCtrl,"🔄 Şerif Yerini Sıfırla",Color3.fromRGB(30,30,60),function()
    sheriffDropPos=nil SheriffDropMarker.Visible=false SheriffDropLabel.Visible=false
    lblSherDrop.set("Henüz düşmedi",T.Faint) notify("Radar","Sıfırlandı","info")
end)

-- ═══ ESP TABU ═══
local secESP=makeSection(tESP,"ESP Ayarları","👁")
local espMurd=makeToggle(secESP,"Katil ESP","Kırmızı — çantada bile tespit")
local espSher=makeToggle(secESP,"Şerif ESP","Sarı — çantada bile tespit")
local espInno=makeToggle(secESP,"Masum ESP","Mavi renk")
local espDead=makeToggle(secESP,"Ölü ESP","Hayaletleri göster")
local espChams=makeToggle(secESP,"Chams","Duvardan renkli görünüm")
local espTracer=makeToggle(secESP,"Tracer","Oyunculara çizgi çek")
local espBox=makeToggle(secESP,"Kutu (Box)","Oyuncuların etrafına kutu")
local espDist=makeToggle(secESP,"Mesafe Göster","Kaç studs uzakta")
local espHealth=makeToggle(secESP,"Can Göster","HP bilgisi")

-- ═══ AIM TABU ═══
local secAim=makeSection(tAim,"Aimbot","🎯")
local autoAim=makeToggle(secAim,"Auto-Aim","Şerif silahıyla katile yumuşak nişan")
local autoShoot=makeToggle(secAim,"Auto-Shoot","Nişan alınca otomatik ateş")
local aimWall=makeToggle(secAim,"Duvar Kontrolü","Sadece görünürse nişan al")
local aimKnife=makeToggle(secAim,"Katil Modu","Katilken şerife nişan al")
local showFOV=makeToggle(secAim,"FOV Dairesi Göster")
local aimSmooth=makeSlider(secAim,"Pürüzsüzlük",1,20,8,"x",function() end)
local aimFOV=makeSlider(secAim,"FOV",20,400,120,"px",function() end)

-- ═══ HAREKET TABU ═══
local secFly=makeSection(tMove,"Uçuş","✈️")
local flyTog=makeToggle(secFly,"Uçma","WASD + Space/Shift")
local flySpeed=makeSlider(secFly,"Uçuş Hızı",10,200,60," sp",function() end)
local secWalk=makeSection(tMove,"Yürüyüş","🏃")
local speedTog=makeToggle(secWalk,"Hız Hilesi")
local speedVal=makeSlider(secWalk,"Hız",16,200,60," sp",function() end)
local jumpTog=makeToggle(secWalk,"Yüksek Zıplama")
local jumpVal=makeSlider(secWalk,"Zıplama Gücü",50,300,50," ",function() end)
local noclipTog=makeToggle(secWalk,"NoClip","Duvarlardan geç")
local bhopTog=makeToggle(secWalk,"BunnyHop","Otomatik zıpla")
local infJump=makeToggle(secWalk,"Sonsuz Zıplama","Havada tekrar zıpla")
local secTP=makeSection(tMove,"Işınlanma","📍")
makeButton(secTP,"📍 Katile Işınlan",T.AccentDrk,function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and getPlayerRole(p)=="murderer" then
            local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local t=p.Character:FindFirstChild("HumanoidRootPart")
            if r and t then r.CFrame=t.CFrame+Vector3.new(5,0,0) notify("Işınlandı","Katile: "..p.Name,"warn") end
        end
    end
end)
makeButton(secTP,"📍 Şerife Işınlan",Color3.fromRGB(100,70,0),function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character and getPlayerRole(p)=="sheriff" then
            local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local t=p.Character:FindFirstChild("HumanoidRootPart")
            if r and t then r.CFrame=t.CFrame+Vector3.new(5,0,0) notify("Işınlandı","Şerife: "..p.Name,"info") end
        end
    end
end)
makeButton(secTP,"🔫 Şerif Silahına Işınlan",Color3.fromRGB(60,50,0),function()
    if sheriffDropPos then
        local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if r then r.CFrame=CFrame.new(sheriffDropPos+Vector3.new(0,3,0)) notify("Işınlandı","Şerif silahına!","success") end
    else notify("Hata","Şerif henüz ölmedi","warn") end
end)
makeButton(secTP,"🏠 Spawn'a Dön",Color3.fromRGB(20,50,20),function()
    local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if r then r.CFrame=CFrame.new(0,5,0) end
end)

-- ═══ SİLAH TABU ═══
local secFakeW=makeSection(tWeap,"Görsel Silahlar","⚔️")
lbl(secFakeW,"Sadece sen görebilirsin",11,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,0,0,0),UDim2.new(1,0,0,20))
local fakeWeapons={}
local function makeFakeKnife(color,neon)
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    fakeWeapons.rainbow=nil
    local char=LocalPlayer.Character if not char then return end
    local hand=char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") if not hand then return end
    local m=Instance.new("Model") m.Parent=Workspace
    -- Bıçak
    local blade=Instance.new("Part") blade.Size=Vector3.new(0.08,0.55,0.06) blade.Color=color blade.Material=neon and Enum.Material.Neon or Enum.Material.Metal blade.CanCollide=false blade.Anchored=false blade.CastShadow=false blade.Parent=m
    local w=Instance.new("WeldConstraint") w.Part0=blade w.Part1=hand w.Parent=blade blade.CFrame=hand.CFrame*CFrame.new(0,-0.55,-0.15)
    -- Sap
    local handle=Instance.new("Part") handle.Size=Vector3.new(0.07,0.25,0.07) handle.Color=Color3.fromRGB(40,25,15) handle.Material=Enum.Material.Wood handle.CanCollide=false handle.Anchored=false handle.Parent=m
    local w2=Instance.new("WeldConstraint") w2.Part0=handle w2.Part1=hand w2.Parent=handle handle.CFrame=hand.CFrame*CFrame.new(0,-0.2,-0.15)
    fakeWeapons.active=m
    if neon then fakeWeapons.rainbowPart=blade end
end
makeButton(secFakeW,"🗡 Klasik Bıçak",T.AccentDrk,function() makeFakeKnife(Color3.fromRGB(200,200,215)) fakeWeapons.rainbowPart=nil notify("Silah","Klasik bıçak","success") end)
makeButton(secFakeW,"✨ Altın Bıçak",Color3.fromRGB(100,70,0),function() makeFakeKnife(Color3.fromRGB(255,200,0),true) fakeWeapons.rainbowPart=nil notify("Silah","Altın bıçak","success") end)
makeButton(secFakeW,"💎 Elmas Bıçak",Color3.fromRGB(0,50,100),function() makeFakeKnife(Color3.fromRGB(100,220,255),true) fakeWeapons.rainbowPart=nil notify("Silah","Elmas bıçak","success") end)
makeButton(secFakeW,"🟣 Mor Bıçak",Color3.fromRGB(60,0,100),function() makeFakeKnife(Color3.fromRGB(180,50,255),true) fakeWeapons.rainbowPart=nil notify("Silah","Mor bıçak","success") end)
makeButton(secFakeW,"🔴 Kırmızı Bıçak",T.AccentDrk,function() makeFakeKnife(Color3.fromRGB(255,30,30),true) fakeWeapons.rainbowPart=nil notify("Silah","Kırmızı bıçak","success") end)
makeButton(secFakeW,"🌈 Gökkuşağı Bıçak",Color3.fromRGB(80,80,80),function() makeFakeKnife(Color3.fromRGB(255,255,255),true) notify("Silah","Gökkuşağı bıçak","success") end)
makeButton(secFakeW,"🔫 Şerif Silahı",Color3.fromRGB(30,30,50),function()
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    fakeWeapons.rainbowPart=nil
    local char=LocalPlayer.Character if not char then return end
    local hand=char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") if not hand then return end
    local m=Instance.new("Model") m.Parent=Workspace
    local barrel=Instance.new("Part") barrel.Size=Vector3.new(0.09,0.09,0.5) barrel.Color=Color3.fromRGB(55,55,62) barrel.Material=Enum.Material.Metal barrel.CanCollide=false barrel.Anchored=false barrel.Parent=m
    local h2=Instance.new("Part") h2.Size=Vector3.new(0.09,0.25,0.09) h2.Color=Color3.fromRGB(80,40,20) h2.Material=Enum.Material.Wood h2.CanCollide=false h2.Anchored=false h2.Parent=m
    local w1=Instance.new("WeldConstraint") w1.Part0=barrel w1.Part1=hand w1.Parent=barrel barrel.CFrame=hand.CFrame*CFrame.new(0,0,-0.3)
    local w2=Instance.new("WeldConstraint") w2.Part0=h2 w2.Part1=hand w2.Parent=h2 h2.CFrame=hand.CFrame*CFrame.new(0,-0.18,-0.08)
    fakeWeapons.active=m notify("Silah","Şerif silahı","success")
end)
makeButton(secFakeW,"❌ Silahı Kaldır",Color3.fromRGB(40,15,15),function()
    if fakeWeapons.active then fakeWeapons.active:Destroy() fakeWeapons.active=nil end
    fakeWeapons.rainbowPart=nil notify("Silah","Kaldırıldı","info")
end)

-- ═══ OYUN TABU ═══
local secGameOpts=makeSection(tGame,"Oyun Seçenekleri","🎮")
local antiVoid=makeToggle(secGameOpts,"Anti-Void","Void'e düşünce kurtarır")
local autoCoin=makeToggle(secGameOpts,"Auto Coin","En yakın altını topla")
local fullbright=makeToggle(secGameOpts,"Fullbright","Karanlığı kaldır")
local antiAFK=makeToggle(secGameOpts,"Anti-AFK","AFK atılmayı engelle")
local autoWin=makeToggle(secGameOpts,"Katil Uzak Tut","Katili senden uzaklaştır (deneysel)")
makeButton(secGameOpts,"💰 Altına Işınlan",T.AccentDrk,function()
    local mc=LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart") if not mr then return end
    local closest,cd=nil,math.huge
    for _,obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
            local d=(obj.Position-mr.Position).Magnitude if d<cd then closest=obj cd=d end
        end
    end
    if closest then mr.CFrame=CFrame.new(closest.Position+Vector3.new(0,3,0)) notify("Altın","Işınlandın!","success")
    else notify("Altın","Bulunamadı","warn") end
end)
makeButton(secGameOpts,"🪙 Tüm Altınları Topla",Color3.fromRGB(80,60,0),function()
    local mc=LocalPlayer.Character local mr=mc and mc:FindFirstChild("HumanoidRootPart") if not mr then return end
    local count=0
    for _,obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
            pcall(function() firetouchinterest(mr,obj,0) firetouchinterest(mr,obj,1) count=count+1 end)
        end
    end
    notify("Altın",count.." altına dokunuldu","success")
end)

-- ═══ EĞLENCE TABU ═══
local secChat=makeSection(tFun,"Chat","💬")
local chatSpam=makeToggle(secChat,"Chat Spam","Otomatik mesaj gönder")
local chatMsgs={"gg","ez","nice try","too easy","lol"}
local chatIdx=1
makeButton(secChat,"💬 'gg' Yaz",Color3.fromRGB(40,40,60),function()
    pcall(function() game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("gg ez","All") end)
end)

local secLook=makeSection(tFun,"Görünüm","🎨")
local rainbow=makeToggle(secLook,"Gökkuşağı Karakter","Rengin sürekli değişir")
makeButton(secLook,"🔵 Mavi Ol",Color3.fromRGB(20,50,100),function()
    local char=LocalPlayer.Character if not char then return end
    for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.Color=Color3.fromRGB(50,120,255) end) end end
    notify("Görünüm","Mavi","info")
end)
makeButton(secLook,"🔴 Kırmızı Ol",Color3.fromRGB(100,20,20),function()
    local char=LocalPlayer.Character if not char then return end
    for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.Color=Color3.fromRGB(255,50,50) end) end end
    notify("Görünüm","Kırmızı","info")
end)
makeButton(secLook,"🟢 Yeşil Ol",Color3.fromRGB(20,80,20),function()
    local char=LocalPlayer.Character if not char then return end
    for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.Color=Color3.fromRGB(50,255,100) end) end end
    notify("Görünüm","Yeşil","info")
end)
makeButton(secLook,"✨ Neon Ol",Color3.fromRGB(60,60,100),function()
    local char=LocalPlayer.Character if not char then return end
    for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then pcall(function() p.Material=Enum.Material.Neon end) end end
    notify("Görünüm","Neon","info")
end)
makeButton(secLook,"👻 Görünmez Ol",Color3.fromRGB(40,40,40),function()
    local char=LocalPlayer.Character if not char then return end
    for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then pcall(function() p.Transparency=1 end) end end
    notify("Görünüm","Görünmez (sadece sende)","info")
end)

local secTrail=makeSection(tFun,"Efektler","🌟")
local trailTog=makeToggle(secTrail,"İz Efekti","Hareket ederken iz bırak")
local spinTog=makeToggle(secTrail,"Dönme Efekti","Karakter döner (görsel)")

-- ══════════════════════════════════════════════════════════════
--  DEĞİŞKENLER
-- ══════════════════════════════════════════════════════════════
local flyBV,flyBG=nil,nil
local safePos=Vector3.new(0,5,0)
local detectedMurderer,detectedSheriff=nil,nil
local lastMurdNotify=0
local roundStart=tick()
local tracerLines={}
local boxFrames={}
local trailPart=nil
local noclipWasOn=false
local roundIdleTime=0
local allToggles={espMurd,espSher,espInno,espDead,espChams,espTracer,espBox,espDist,espHealth,
    autoAim,autoShoot,aimWall,aimKnife,showFOV,flyTog,speedTog,jumpTog,noclipTog,bhopTog,infJump,
    antiVoid,autoCoin,fullbright,antiAFK,autoWin,chatSpam,rainbow,trailTog,spinTog,radarTog}

-- Görsel katmanı (tracer + box + FOV)
local VisGui=mount(Instance.new("ScreenGui"))
VisGui.Name="MM2Visuals" VisGui.ResetOnSpawn=false VisGui.DisplayOrder=995
local FOVFrame=Instance.new("Frame") FOVFrame.BackgroundTransparency=1 FOVFrame.Size=UDim2.new(0,240,0,240) FOVFrame.Position=UDim2.new(0.5,-120,0.5,-120) FOVFrame.Parent=VisGui FOVFrame.Visible=false
local FOVImg=Instance.new("ImageLabel") FOVImg.Size=UDim2.new(1,0,1,0) FOVImg.BackgroundTransparency=1 FOVImg.Image="rbxassetid://3570695787" FOVImg.ImageColor3=T.Accent FOVImg.ImageTransparency=0.4 FOVImg.Parent=FOVFrame

local function flyCallback(on)
    local char=LocalPlayer.Character if not char then return end
    local root=char:FindFirstChild("HumanoidRootPart") local hum=char:FindFirstChild("Humanoid") if not root then return end
    if on then
        if hum then hum.PlatformStand=true end
        flyBV=Instance.new("BodyVelocity") flyBV.Velocity=Vector3.zero flyBV.MaxForce=Vector3.new(1e5,1e5,1e5) flyBV.Parent=root
        flyBG=Instance.new("BodyGyro") flyBG.MaxTorque=Vector3.new(1e5,1e5,1e5) flyBG.P=1e4 flyBG.Parent=root
    else
        if hum then hum.PlatformStand=false end
        if flyBV then flyBV:Destroy() flyBV=nil end
        if flyBG then flyBG:Destroy() flyBG=nil end
    end
end

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    if antiAFK:get() then
        local vu=game:GetService("VirtualUser")
        vu:CaptureController() vu:ClickButton2(Vector2.new())
    end
end)

-- Sonsuz zıplama
UserInputService.JumpRequest:Connect(function()
    if infJump:get() then
        local char=LocalPlayer.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ══════════════════════════════════════════════════════════════
--  PENCERE EKRANDA KALSIN
-- ══════════════════════════════════════════════════════════════
-- Ekran boyutu değişirse (tam ekran/pencere geçişi) menüyü ortala
Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    local vs=Camera.ViewportSize
    -- Pencere ekran dışında kaldıysa ortala
    local absPos=Main.AbsolutePosition
    local absSize=Main.AbsoluteSize
    if absPos.X<0 or absPos.Y<0 or absPos.X+absSize.X>vs.X or absPos.Y+absSize.Y>vs.Y then
        Main.Position=UDim2.new(0.5,-absSize.X/2,0.5,-absSize.Y/2)
        GlowGui.Position=UDim2.new(0.5,-(absSize.X+30)/2,0.5,-(absSize.Y+30)/2)
    end
end)

-- Glow menüyle birlikte hareket etsin
Main:GetPropertyChangedSignal("Position"):Connect(function()
    GlowGui.Position=UDim2.new(
        Main.Position.X.Scale, Main.Position.X.Offset-15,
        Main.Position.Y.Scale, Main.Position.Y.Offset-15
    )
end)
-- Not: Glow boyutu doMinimize() içinde yönetilir, burada dinleyici yok
-- (iki yerden aynı anda değiştirilirse arkada iz kalıyordu)

-- ══════════════════════════════════════════════════════════════
--  TEMİZLİK & YENİDEN DOĞMA YÖNETİMİ
-- ══════════════════════════════════════════════════════════════

-- Oyuncu ayrılınca ona ait görselleri temizle (hafıza sızıntısı önlenir)
Players.PlayerRemoving:Connect(function(p)
    local n=p.Name
    if tracerLines[n] then pcall(function() tracerLines[n]:Destroy() end) tracerLines[n]=nil end
    if boxFrames[n] then pcall(function() boxFrames[n]:Destroy() end) boxFrames[n]=nil end
    if radarDots[n] then pcall(function() radarDots[n].dot:Destroy() end) radarDots[n]=nil end
    -- Şerif çıktıysa takibi sıfırla
    if lastSheriffName==n then lastSheriffName=nil end
end)

-- Yeni oyuncu girince eski artık kalmasın
Players.PlayerAdded:Connect(function(p)
    local n=p.Name
    if tracerLines[n] then pcall(function() tracerLines[n]:Destroy() end) tracerLines[n]=nil end
    if boxFrames[n] then pcall(function() boxFrames[n]:Destroy() end) boxFrames[n]=nil end
    if radarDots[n] then pcall(function() radarDots[n].dot:Destroy() end) radarDots[n]=nil end
end)

-- Kendimiz yeniden doğunca: fly'ı temizle, yeni round algıla
LocalPlayer.CharacterAdded:Connect(function(newChar)
    -- Fly nesnelerini temizle (eski karaktere bağlıydılar)
    flyBV=nil flyBG=nil trailPart=nil
    -- Yeni round başlamış olabilir → şerif takibini ve timer'ı sıfırla
    task.wait(1)
    sheriffDropPos=nil
    lastSheriffName=nil
    SheriffDropMarker.Visible=false
    SheriffDropLabel.Visible=false
    pcall(function() lblSherDrop.set("Henüz düşmedi",T.Faint) end)
    roundStart=tick()
    -- Aktif hileleri yeni karaktere tekrar uygula
    if flyTog:get() then flyCallback(true) end
    notify("Yeni Round","Şerif takibi sıfırlandı","info",3)
end)

-- ══════════════════════════════════════════════════════════════
--  TUŞLAR
-- ══════════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.Insert then
        Main.Visible=not Main.Visible GlowGui.Visible=Main.Visible
        if Main.Visible then
            -- Her açılışta ekran içinde olduğundan emin ol
            local vs=Camera.ViewportSize
            local w=Main.AbsoluteSize.X>0 and Main.AbsoluteSize.X or WIN_W
            local h=Main.AbsoluteSize.Y>0 and Main.AbsoluteSize.Y or WIN_H
            local ax=Main.Position.X.Scale*vs.X+Main.Position.X.Offset
            local ay=Main.Position.Y.Scale*vs.Y+Main.Position.Y.Offset
            if ax<0 or ay<0 or ax+w>vs.X or ay+h>vs.Y then
                Main.Position=UDim2.new(0.5,-w/2,0.5,-h/2)
            end
            Main.GroupTransparency=1 tw(Main,{GroupTransparency=0},0.3)
        end
    elseif input.KeyCode==Enum.KeyCode.Delete then
        for _,t in pairs(allToggles) do pcall(function() t:set(false) end) end
        flyCallback(false)
        if fakeWeapons.active then fakeWeapons.active:Destroy() fakeWeapons.active=nil end
        fakeWeapons.rainbowPart=nil Lighting.Brightness=1
        notify("PANIC","Tüm hileler kapatıldı!","error") setStatus("Panic — Hepsi kapatıldı","warn")
    elseif input.KeyCode==Enum.KeyCode.End then
        wmFrame.Visible=not wmFrame.Visible
    elseif input.KeyCode==Enum.KeyCode.Home then
        doMinimize()
    end
end)

-- ══════════════════════════════════════════════════════════════
--  ANA DÖNGÜ (optimize edilmiş)
--  Hafif işler (fly, hız, kamera) her frame çalışır.
--  Ağır işler (ESP, rol tespiti, radar) saniyede ~10 kez çalışır.
-- ══════════════════════════════════════════════════════════════
local fpsCount,fpsAccum,chatTimer=0,0,0
local heavyTimer=0
local HEAVY_INTERVAL=0.1  -- saniyede 10 kez ağır işlem

-- Önbellek (her frame yeniden hesaplama)
local cachedMurderer,cachedSheriff=nil,nil

RunService.Heartbeat:Connect(function(dt)
    fpsCount=fpsCount+1 fpsAccum=fpsAccum+dt chatTimer=chatTimer+dt heavyTimer=heavyTimer+dt
    if fpsAccum>=1 then
        local fps=math.floor(fpsCount/fpsAccum)
        lblFPS.set(fps.." FPS") wmInfo.Text=fps.." FPS"
        fpsCount=0 fpsAccum=0
    end

    local char=LocalPlayer.Character if not char then return end
    local hum=char:FindFirstChild("Humanoid")
    local root=char:FindFirstChild("HumanoidRootPart")

    -- ─── HER FRAME (hafif, akıcılık için) ───
    if root and root.Position.Y>-50 then safePos=root.Position end
    if antiVoid:get() and root and root.Position.Y<-100 then
        root.CFrame=CFrame.new(safePos+Vector3.new(0,5,0)) notify("Anti-Void","Kurtarıldın!","warn")
    end

    -- Hız: açıkken uygula, kapanınca normale döndür
    if speedTog:get() and hum then
        hum.WalkSpeed=speedVal.get()
    elseif hum and hum.WalkSpeed~=16 and not speedTog:get() then
        hum.WalkSpeed=16
    end

    -- Zıplama: açıkken uygula, kapanınca normale döndür
    if jumpTog:get() and hum then
        hum.UseJumpPower=true hum.JumpPower=jumpVal.get()
    elseif hum and hum.UseJumpPower and hum.JumpPower~=50 and not jumpTog:get() then
        hum.JumpPower=50
    end

    if bhopTog:get() and hum then if hum.FloorMaterial~=Enum.Material.Air then hum.Jump=true end end

    -- Fly (her frame — akıcı olmalı)
    if flyTog:get() then
        if not flyBV or not flyBV.Parent then flyCallback(true) end
        if flyBV and flyBG then
            local d=Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then d=d+Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then d=d-Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then d=d-Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then d=d+Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d=d+Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d=d-Vector3.new(0,1,0) end
            flyBV.Velocity=d.Magnitude>0 and d.Unit*flySpeed.get() or Vector3.zero
            flyBG.CFrame=Camera.CFrame
        end
    else
        if flyBV then flyCallback(false) end
    end

    -- ═══ AUTO-AIM (yeniden yazıldı) ═══
    if autoAim:get() and root then
        -- 1) Elimizde ne var? Hem tool hem backpack kontrol edilir.
        local myTool=char:FindFirstChildWhichIsA("Tool")
        local myTN=myTool and myTool.Name:lower() or ""
        local hasGun=(myTN:find("gun") or myTN:find("sheriff") or myTN:find("revolver") or myTN:find("pistol")) and true or false
        local hasKnife=(myTN:find("knife") or myTN:find("blade")) and true or false

        -- 2) Hedef seç. Rol önbelleği boşsa anlık tespit yap (ilk saniyede boş kalmasın)
        local targetPlayer=nil
        local wantRole=nil
        if hasGun then wantRole="murderer"
        elseif aimKnife:get() and hasKnife then wantRole="sheriff" end

        if wantRole then
            -- Önce önbellekten dene
            local cachedName=(wantRole=="murderer") and cachedMurderer or cachedSheriff
            if cachedName then
                local cp=Players:FindFirstChild(cachedName)
                if cp and cp.Character then targetPlayer=cp end
            end
            -- Önbellek boşsa/geçersizse anlık tara
            if not targetPlayer then
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=LocalPlayer and p.Character and getPlayerRole(p)==wantRole then targetPlayer=p break end
                end
            end
        end

        -- 3) Hedef geçerli mi? (ölü hedefe nişan alma)
        if targetPlayer and targetPlayer.Character then
            local tc=targetPlayer.Character
            local tHum=tc:FindFirstChildOfClass("Humanoid")
            local isAlive=tHum and tHum.Health>0

            -- En iyi hedef parçası: Head > UpperTorso > HumanoidRootPart
            local tr=tc:FindFirstChild("Head") or tc:FindFirstChild("UpperTorso") or tc:FindFirstChild("HumanoidRootPart")

            if isAlive and tr then
                local sp,onScreen=Camera:WorldToViewportPoint(tr.Position)
                -- sp.Z>0 kontrolü: hedef kameranın ARKASINDA değilse
                if onScreen and sp.Z>0 then
                    local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
                    local diff=Vector2.new(sp.X,sp.Y)-center

                    if diff.Magnitude<=aimFOV.get() then
                        -- 4) Duvar kontrolü (isteğe bağlı)
                        local canSee=true
                        if aimWall:get() then
                            local rp=RaycastParams.new()
                            rp.FilterDescendantsInstances={char,tc}   -- hem kendimizi hem hedefi yok say
                            rp.FilterType=Enum.RaycastFilterType.Exclude
                            local dir=tr.Position-Camera.CFrame.Position
                            local res=Workspace:Raycast(Camera.CFrame.Position,dir,rp)
                            -- Arada BAŞKA bir şey varsa görüş kapalı
                            if res then canSee=false end
                        end

                        if canSee then
                            -- 5) Kamerayı yumuşakça hedefe çevir.
                            -- Pozisyonu KORUYUP sadece bakış yönünü değiştiriyoruz.
                            local camPos=Camera.CFrame.Position
                            local goalCF=CFrame.lookAt(camPos,tr.Position)
                            local alpha=math.clamp(dt*aimSmooth.get(),0,1)
                            Camera.CFrame=Camera.CFrame:Lerp(goalCF,alpha)

                            -- 6) Otomatik ateş — çeşitli executor API'lerini dene
                            if autoShoot:get() and hasGun then
                                pcall(function()
                                    if mouse1click then mouse1click()
                                    elseif mouse1press then mouse1press() task.delay(0.06,function() pcall(mouse1release) end) end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end

    FOVFrame.Visible=showFOV:get() and autoAim:get()
    if FOVFrame.Visible then local fov=aimFOV.get()*2 FOVFrame.Size=UDim2.new(0,fov,0,fov) FOVFrame.Position=UDim2.new(0.5,-fov/2,0.5,-fov/2) end

    -- Round timer (hafif)
    local rt=tick()-roundStart
    lblRound.set(string.format("%d:%02d",math.floor(rt/60),math.floor(rt%60)))

    -- ═══════════════════════════════════════════
    --  AĞIR İŞLER — saniyede ~10 kez (FPS dostu)
    -- ═══════════════════════════════════════════
    if heavyTimer<HEAVY_INTERVAL then return end
    heavyTimer=0

    -- NoClip: açıkken çarpışmayı kapat, kapatılınca GERİ AÇ
    if noclipTog:get() then
        noclipWasOn=true
        for _,p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide=false end
        end
    elseif noclipWasOn then
        -- Sadece bir kez çalışsın, sürekli değil
        noclipWasOn=false
        for _,p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then p.CanCollide=true end
        end
    end

    if fullbright:get() then Lighting.Brightness=10 Lighting.FogEnd=1e6 Lighting.ClockTime=14 end
    if rainbow:get() then
        local color=Color3.fromHSV(tick()%5/5,1,1)
        for _,p in pairs(char:GetDescendants()) do pcall(function() if p:IsA("BasePart") then p.Color=color end end) end
    end
    if fakeWeapons.rainbowPart then fakeWeapons.rainbowPart.Color=Color3.fromHSV(tick()%2/2,1,1) end

    -- İz efekti
    if trailTog:get() and root then
        if not trailPart or not trailPart.Parent then
            trailPart=Instance.new("Trail")
            local a0=Instance.new("Attachment") a0.Position=Vector3.new(0,1,0) a0.Parent=root a0.Name="_ta0"
            local a1=Instance.new("Attachment") a1.Position=Vector3.new(0,-1,0) a1.Parent=root a1.Name="_ta1"
            trailPart.Attachment0=a0 trailPart.Attachment1=a1 trailPart.Lifetime=0.5 trailPart.Parent=root
        end
        trailPart.Color=ColorSequence.new(Color3.fromHSV(tick()%3/3,1,1))
    elseif trailPart then trailPart:Destroy() trailPart=nil pcall(function() root._ta0:Destroy() root._ta1:Destroy() end) end

    -- Chat spam
    if chatSpam:get() and chatTimer>3 then
        chatTimer=0
        pcall(function() chatIdx=chatIdx%#chatMsgs+1 game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatMsgs[chatIdx],"All") end)
    end

    -- ROL TESPİTİ
    local murdName,sherName=nil,nil
    local aliveCount,deadCount=0,0
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hum2=p.Character:FindFirstChild("Humanoid")
            if hum2 then if hum2.Health>0 then aliveCount=aliveCount+1 else deadCount=deadCount+1 end end
            if p~=LocalPlayer then
                local role=getPlayerRole(p)
                if role=="murderer" then murdName=p.Name elseif role=="sheriff" then sherName=p.Name end
            end
        end
    end
    cachedMurderer=murdName cachedSheriff=sherName  -- auto-aim için önbellek
    local myRoleNow=getPlayerRole(LocalPlayer)

    -- ═══ ROUND DEĞİŞİMİ ALGILAMA ═══
    -- Katil de şerif de yoksa round bitmiş demektir → takibi sıfırla
    if not murdName and not sherName and myRoleNow=="innocent" then
        roundIdleTime=roundIdleTime+HEAVY_INTERVAL
        if roundIdleTime>4 and sheriffDropPos then
            sheriffDropPos=nil lastSheriffName=nil
            SheriffDropMarker.Visible=false SheriffDropLabel.Visible=false
            lblSherDrop.set("Henüz düşmedi",T.Faint)
            roundStart=tick()
            notify("Round Bitti","Takip sıfırlandı","info",3)
        end
    else
        roundIdleTime=0
    end

    -- Kendimiz de şerif olabiliriz — onu da hesaba kat
    if myRoleNow=="sheriff" then lastSheriffName=LocalPlayer.Name
    elseif sherName then lastSheriffName=sherName end

    -- Şerif ölünce silah yeri kaydet
    -- ÖNEMLİ: Ölen kişinin GERÇEKTEN şerif olduğunu doğrula (sadece isim eşleşmesi yeterli değil)
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hum2=p.Character:FindFirstChild("Humanoid")
            local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
            -- Bu oyuncu şerif miydi? (lastSheriffName ile eşleşmeli VE kendisi LocalPlayer olmamalı — kendi silahımızı takip etmiyoruz)
            if p~=LocalPlayer and lastSheriffName==p.Name and hum2 and hum2.Health<=0 and not sheriffDropPos and pRoot then
                sheriffDropPos=pRoot.Position
                SheriffDropMarker.Visible=true SheriffDropLabel.Visible=true SheriffDropLabel.Text="🔫 "..p.Name
                lblSherDrop.set("📍 "..math.floor(pRoot.Position.X)..","..math.floor(pRoot.Position.Y)..","..math.floor(pRoot.Position.Z),T.Sher)
                notify("⚠️ ŞERİF ÖLDÜ!",p.Name.."'nin silahı burada!","warn",8)
            end
        end
    end

    local myRole=myRoleNow
    lblMyRole.set(roleText(myRole,false),roleColor(myRole,false))

    if murdName and murdName~=detectedMurderer then
        detectedMurderer=murdName
        if tick()-lastMurdNotify>8 then notify("⚠️ KATİL TESPİT!",murdName.." katil!","error",6) lastMurdNotify=tick() end
    end
    if not murdName then detectedMurderer=nil end
    detectedSheriff=sherName

    lblMurd.set(detectedMurderer or "Bilinmiyor",detectedMurderer and T.Murd or T.Faint)
    lblSher.set(detectedSheriff or "Bilinmiyor",detectedSheriff and T.Sher or T.Faint)
    lblPlayers.set(#Players:GetPlayers()) lblAlive.set(aliveCount,T.Good) lblDead.set(deadCount,T.Bad)
    pcall(function()
        local ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        lblPing.set(math.floor(ping).."ms",ping<80 and T.Good or ping<150 and T.Warn or T.Bad)
    end)
    SRight.Text=aliveCount.." hayatta"..(detectedMurderer and " · 🔪 "..detectedMurderer or "")

    if sheriffDropPos then
        local myR=char:FindFirstChild("HumanoidRootPart")
        if myR then SheriffDropLabel.Text="🔫 "..math.floor((sheriffDropPos-myR.Position).Magnitude).." st" end
    end

    -- ESP + Chams (ağır kısımda)
    for _,line in pairs(tracerLines) do line.Visible=false end
    for _,box in pairs(boxFrames) do box.Visible=false end
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
            if pRoot then
                local role=getPlayerRole(p)
                local pHum=p.Character:FindFirstChild("Humanoid")
                local isDead=pHum and pHum.Health<=0
                local showESP=(role=="murderer" and espMurd:get()) or (role=="sheriff" and espSher:get()) or (role=="innocent" and espInno:get()) or (isDead and espDead:get())
                local color=roleColor(role,isDead)
                local bb=pRoot:FindFirstChild("_mm2esp")

                if showESP then
                    if not bb then
                        bb=Instance.new("BillboardGui") bb.Name="_mm2esp" bb.Size=UDim2.new(0,155,0,72) bb.StudsOffset=Vector3.new(0,4.5,0) bb.AlwaysOnTop=true bb.Parent=pRoot
                        local bg=Instance.new("Frame") bg.Name="BG" bg.Size=UDim2.new(1,0,1,0) bg.BackgroundColor3=Color3.fromRGB(10,10,13) bg.BackgroundTransparency=0.25 bg.BorderSizePixel=0 bg.Parent=bb corner(bg,6) stroke(bg,color,1,0.3)
                        local nl2=Instance.new("TextLabel") nl2.Name="NL" nl2.Size=UDim2.new(1,-10,0,20) nl2.Position=UDim2.new(0,7,0,3) nl2.BackgroundTransparency=1 nl2.Font=Enum.Font.GothamBold nl2.TextSize=14 nl2.TextStrokeTransparency=0 nl2.TextXAlignment=Enum.TextXAlignment.Left nl2.Parent=bg
                        local rl2=Instance.new("TextLabel") rl2.Name="RL" rl2.Size=UDim2.new(1,-10,0,13) rl2.Position=UDim2.new(0,7,0,23) rl2.BackgroundTransparency=1 rl2.Font=Enum.Font.GothamBold rl2.TextSize=11 rl2.TextStrokeTransparency=0 rl2.TextXAlignment=Enum.TextXAlignment.Left rl2.Parent=bg
                        local hl2=Instance.new("TextLabel") hl2.Name="HL" hl2.Size=UDim2.new(1,-10,0,12) hl2.Position=UDim2.new(0,7,0,38) hl2.BackgroundTransparency=1 hl2.Font=Enum.Font.Gotham hl2.TextSize=10 hl2.TextStrokeTransparency=0.3 hl2.TextXAlignment=Enum.TextXAlignment.Left hl2.Parent=bg
                        local dl2=Instance.new("TextLabel") dl2.Name="DL" dl2.Size=UDim2.new(1,-10,0,12) dl2.Position=UDim2.new(0,7,0,51) dl2.BackgroundTransparency=1 dl2.Font=Enum.Font.Gotham dl2.TextSize=10 dl2.TextStrokeTransparency=0.3 dl2.TextXAlignment=Enum.TextXAlignment.Left dl2.Parent=bg
                        local sb=Instance.new("Frame") sb.Name="SB" sb.Size=UDim2.new(0,3,1,-8) sb.Position=UDim2.new(0,0,0,4) sb.BorderSizePixel=0 sb.Parent=bg corner(sb,2)
                    end
                    local bg=bb:FindFirstChild("BG")
                    if bg then
                        local nl2=bg:FindFirstChild("NL") local rl2=bg:FindFirstChild("RL") local hl2=bg:FindFirstChild("HL") local dl2=bg:FindFirstChild("DL") local sb=bg:FindFirstChild("SB")
                        if nl2 then nl2.Text=p.Name nl2.TextColor3=color end
                        if rl2 then rl2.Text=roleText(role,isDead) rl2.TextColor3=color end
                        if sb then sb.BackgroundColor3=color end
                        if hl2 and espHealth:get() and pHum then
                            hl2.Text="❤️ "..math.floor(pHum.Health).."/"..math.floor(pHum.MaxHealth)
                            hl2.TextColor3=pHum.Health>50 and T.Good or pHum.Health>25 and T.Warn or T.Bad
                        elseif hl2 then hl2.Text="" end
                        if dl2 and espDist:get() then
                            local myR=char:FindFirstChild("HumanoidRootPart")
                            if myR then local d=math.floor((pRoot.Position-myR.Position).Magnitude) dl2.Text="📏 "..d.." st" dl2.TextColor3=d<20 and T.Bad or d<50 and T.Warn or T.Dim end
                        elseif dl2 then dl2.Text="" end
                    end
                else
                    if bb then bb:Destroy() end
                end

                -- Chams
                if espChams:get() then
                    for _,part in pairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") and not part:FindFirstChild("_chams") then
                            local sel=Instance.new("SelectionBox") sel.Name="_chams" sel.Adornee=part sel.Color3=color sel.SurfaceColor3=color sel.SurfaceTransparency=0.7 sel.LineThickness=0.04 sel.Parent=part
                        end
                    end
                else
                    for _,part in pairs(p.Character:GetDescendants()) do if part:IsA("BasePart") then local s=part:FindFirstChild("_chams") if s then s:Destroy() end end end
                end

                -- Tracer & Box
                local sp,onScreen=Camera:WorldToViewportPoint(pRoot.Position)
                if onScreen and (espTracer:get() or espBox:get()) then
                    if espTracer:get() then
                        local line=tracerLines[p.Name]
                        if not line then line=Instance.new("Frame") line.BorderSizePixel=0 line.AnchorPoint=Vector2.new(0.5,0) line.ZIndex=1 line.Parent=VisGui tracerLines[p.Name]=line end
                        line.Visible=true line.BackgroundColor3=color
                        local sBot=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
                        local tgt=Vector2.new(sp.X,sp.Y)
                        local dist=(tgt-sBot).Magnitude
                        line.Size=UDim2.new(0,2,0,dist) line.Position=UDim2.new(0,sBot.X,0,sBot.Y)
                        line.Rotation=math.deg(math.atan2(tgt.Y-sBot.Y,tgt.X-sBot.X))-90
                    end
                    if espBox:get() then
                        local box=boxFrames[p.Name]
                        if not box then box=Instance.new("Frame") box.BackgroundTransparency=1 box.BorderSizePixel=0 box.ZIndex=1 box.Parent=VisGui local bs=stroke(box,color,2) bs.Name="bs" boxFrames[p.Name]=box end
                        box.Visible=true local bs=box:FindFirstChild("bs") if bs then bs.Color=color end
                        local size=math.clamp(2000/(sp.Z+1),20,300)
                        box.Size=UDim2.new(0,size*0.65,0,size)
                        box.Position=UDim2.new(0,sp.X-size*0.325,0,sp.Y-size*0.5)
                    end
                end
            end
        end
    end

    -- Auto coin
    if autoCoin:get() then
        local mr=char:FindFirstChild("HumanoidRootPart")
        if mr then
            local closest,cd=nil,35
            for _,obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
                    local d=(obj.Position-mr.Position).Magnitude if d<cd then closest=obj cd=d end
                end
            end
            if closest then mr.CFrame=CFrame.new(closest.Position+Vector3.new(0,3,0)) end
        end
    end

    -- RADAR
    RadarFrame.Visible=radarTog:get()
    if radarTog:get() then
        for name,data in pairs(radarDots) do data.dot.Visible=false end
        local mr=char:FindFirstChild("HumanoidRootPart")
        if mr then
            for _,p in pairs(Players:GetPlayers()) do
                if p~=LocalPlayer and p.Character then
                    local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
                    if pRoot then
                        local nx,ny=worldToRadar(pRoot.Position)
                        if nx and ny then
                            local role=getPlayerRole(p)
                            local col=roleColor(role,false)
                            local dot=getDot(p.Name)
                            dot.dot.Visible=true dot.dot.Position=UDim2.new(nx,-5,ny,-5) dot.dot.BackgroundColor3=col
                            dot.txt.Text=p.Name:sub(1,6) dot.txt.TextColor3=col
                        end
                    end
                end
            end
            if sheriffDropPos then
                local nx,ny=worldToRadar(sheriffDropPos)
                if nx and ny then
                    SheriffDropMarker.Position=UDim2.new(nx,-8,ny,-8) SheriffDropLabel.Position=UDim2.new(nx,-45,ny,-24)
                    SheriffDropMarker.BackgroundTransparency=math.abs(math.sin(tick()*3))*0.5
                end
            end
        end
    end
end)

_G.__MM2_Destroy=function()
    for _,n in ipairs({GUI,NotifyGui,VisGui,RadarGui,WM}) do pcall(function() n:Destroy() end) end
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    flyCallback(false)
end

setStatus("MM2 Ultimate v3 yüklendi ✓","ok")
notify("MM2 Ultimate v3","7 tab · 60+ özellik · INSERT menü · Sekmelere tıkla!","success",8)
