-- MM2 Ultimate Script
-- loadstring(game:HttpGet("RAW_LINK"))()

pcall(function() if _G.__MM2_Destroy then _G.__MM2_Destroy() end end)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local T = {
    BG=Color3.fromRGB(10,10,13),Surface=Color3.fromRGB(18,18,22),SurfaceHi=Color3.fromRGB(26,26,32),
    Accent=Color3.fromRGB(214,40,56),AccentDark=Color3.fromRGB(140,20,35),
    Text=Color3.fromRGB(240,240,245),Dim=Color3.fromRGB(140,140,150),Faint=Color3.fromRGB(80,80,90),
    Good=Color3.fromRGB(72,199,116),Warn=Color3.fromRGB(232,172,62),Bad=Color3.fromRGB(226,72,72),
    Border=Color3.fromRGB(35,35,42),Murd=Color3.fromRGB(255,60,60),Sher=Color3.fromRGB(255,200,50),
    Inno=Color3.fromRGB(80,160,255),
}

local function tw(i,p,t,s) TweenService:Create(i,TweenInfo.new(t or 0.25,s or Enum.EasingStyle.Quint),p):Play() end
local function corner(i,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=i return c end
local function stroke(i,c,t) local s=Instance.new("UIStroke") s.Color=c or T.Border s.Thickness=t or 1 s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border s.Parent=i return s end
local function lbl(p,txt,sz,col,fnt,xa,pos,s2)
    local l=Instance.new("TextLabel") l.Parent=p l.BackgroundTransparency=1 l.Text=txt or ""
    l.TextSize=sz or 13 l.TextColor3=col or T.Text l.Font=fnt or Enum.Font.Gotham
    l.TextXAlignment=xa or Enum.TextXAlignment.Left l.Position=pos or UDim2.new(0,0,0,0)
    l.Size=s2 or UDim2.new(1,0,1,0) l.TextTruncate=Enum.TextTruncate.AtEnd return l
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

clearOld("MM2Ultimate") clearOld("MM2Notify") clearOld("MM2FOV") clearOld("MM2Radar")

-- BİLDİRİM
local NotifyGui=mount(Instance.new("ScreenGui"))
NotifyGui.Name="MM2Notify" NotifyGui.ResetOnSpawn=false NotifyGui.DisplayOrder=1001
local NH=Instance.new("Frame") NH.Size=UDim2.new(0,300,1,-20) NH.Position=UDim2.new(1,-314,0,10) NH.BackgroundTransparency=1 NH.Parent=NotifyGui
local NL=Instance.new("UIListLayout") NL.Padding=UDim.new(0,8) NL.SortOrder=Enum.SortOrder.LayoutOrder NL.VerticalAlignment=Enum.VerticalAlignment.Top NL.HorizontalAlignment=Enum.HorizontalAlignment.Right NL.Parent=NH
local nC=0

local function notify(title,text,kind,dur)
    nC+=1
    local col=kind=="success" and T.Good or kind=="warn" and T.Warn or kind=="error" and T.Bad or T.Accent
    local glyph=kind=="success" and "✓" or kind=="warn" and "!" or kind=="error" and "✕" or "i"
    dur=dur or 4
    local outer=Instance.new("Frame") outer.Size=UDim2.new(1,0,0,0) outer.BackgroundTransparency=1 outer.LayoutOrder=nC outer.Parent=NH
    local card=Instance.new("Frame") card.Size=UDim2.new(1,0,0,text~="" and 64 or 40) card.Position=UDim2.new(1.3,0,0,0) card.BackgroundColor3=T.Surface card.BorderSizePixel=0 card.Parent=outer corner(card,10) stroke(card,T.Border,1)
    local bar=Instance.new("Frame") bar.Size=UDim2.new(0,3,1,-16) bar.Position=UDim2.new(0,0,0,8) bar.BackgroundColor3=col bar.BorderSizePixel=0 bar.Parent=card corner(bar,2)
    local gi=Instance.new("Frame") gi.Size=UDim2.new(0,28,0,28) gi.Position=UDim2.new(0,10,0,8) gi.BackgroundColor3=col gi.BackgroundTransparency=0.8 gi.BorderSizePixel=0 gi.Parent=card corner(gi,6)
    lbl(gi,glyph,14,col,Enum.Font.GothamBold,Enum.TextXAlignment.Center)
    lbl(card,title,13,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,46,0,9),UDim2.new(1,-58,0,16))
    if text~="" then lbl(card,text,11,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,46,0,27),UDim2.new(1,-58,0,30)) end
    local prog=Instance.new("Frame") prog.Size=UDim2.new(1,0,0,2) prog.AnchorPoint=Vector2.new(0,1) prog.Position=UDim2.new(0,0,1,0) prog.BackgroundColor3=col prog.BorderSizePixel=0 prog.Parent=card corner(prog,1)
    tw(outer,{Size=UDim2.new(1,0,0,(text~="" and 64 or 40)+6)},0.5)
    tw(card,{Position=UDim2.new(0,0,0,0)},0.5,Enum.EasingStyle.Back)
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

-- RADAR
local RadarGui=mount(Instance.new("ScreenGui"))
RadarGui.Name="MM2Radar" RadarGui.ResetOnSpawn=false RadarGui.DisplayOrder=997
local RadarFrame=Instance.new("Frame")
RadarFrame.Size=UDim2.new(0,180,0,180) RadarFrame.Position=UDim2.new(1,-194,1,-194)
RadarFrame.BackgroundColor3=Color3.fromRGB(10,10,13) RadarFrame.BackgroundTransparency=0.2
RadarFrame.BorderSizePixel=0 RadarFrame.Visible=false RadarFrame.Parent=RadarGui
corner(RadarFrame,90) stroke(RadarFrame,T.Accent,2)

local RadarTitle=Instance.new("TextLabel") RadarTitle.Size=UDim2.new(1,0,0,20) RadarTitle.Position=UDim2.new(0,0,0,-24) RadarTitle.BackgroundTransparency=1 RadarTitle.Text="📡 RADAR" RadarTitle.TextColor3=T.Accent RadarTitle.Font=Enum.Font.GothamBold RadarTitle.TextSize=11 RadarTitle.Parent=RadarFrame

local function makeGridLine(horiz)
    local f=Instance.new("Frame") f.BackgroundColor3=Color3.fromRGB(35,35,45) f.BorderSizePixel=0
    if horiz then f.Size=UDim2.new(1,0,0,1) f.Position=UDim2.new(0,0,0.5,0)
    else f.Size=UDim2.new(0,1,1,0) f.Position=UDim2.new(0.5,0,0,0) end
    f.Parent=RadarFrame
end
makeGridLine(true) makeGridLine(false)

local RadarCenter=Instance.new("Frame") RadarCenter.Size=UDim2.new(0,8,0,8) RadarCenter.AnchorPoint=Vector2.new(0.5,0.5) RadarCenter.Position=UDim2.new(0.5,0,0.5,0) RadarCenter.BackgroundColor3=T.Good RadarCenter.BorderSizePixel=0 RadarCenter.ZIndex=3 RadarCenter.Parent=RadarFrame corner(RadarCenter,4)

local SheriffDropMarker=Instance.new("Frame") SheriffDropMarker.Size=UDim2.new(0,14,0,14) SheriffDropMarker.AnchorPoint=Vector2.new(0.5,0.5) SheriffDropMarker.BackgroundColor3=T.Sher SheriffDropMarker.BorderSizePixel=0 SheriffDropMarker.ZIndex=4 SheriffDropMarker.Visible=false SheriffDropMarker.Parent=RadarFrame corner(SheriffDropMarker,3)
lbl(SheriffDropMarker,"🔫",10,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Center)

local SheriffDropLabel=Instance.new("TextLabel") SheriffDropLabel.Size=UDim2.new(0,80,0,16) SheriffDropLabel.AnchorPoint=Vector2.new(0.5,0) SheriffDropLabel.BackgroundColor3=Color3.fromRGB(10,10,13) SheriffDropLabel.BackgroundTransparency=0.3 SheriffDropLabel.BorderSizePixel=0 SheriffDropLabel.Text="" SheriffDropLabel.TextColor3=T.Sher SheriffDropLabel.Font=Enum.Font.GothamBold SheriffDropLabel.TextSize=9 SheriffDropLabel.ZIndex=5 SheriffDropLabel.Visible=false SheriffDropLabel.Parent=RadarFrame corner(SheriffDropLabel,4)

local radarDots={}
local function getOrCreateDot(name)
    if not radarDots[name] then
        local dot=Instance.new("Frame") dot.Size=UDim2.new(0,10,0,10) dot.AnchorPoint=Vector2.new(0.5,0.5) dot.BorderSizePixel=0 dot.ZIndex=2 dot.Parent=RadarFrame corner(dot,5)
        local dtxt=Instance.new("TextLabel") dtxt.Size=UDim2.new(0,60,0,12) dtxt.AnchorPoint=Vector2.new(0.5,1) dtxt.Position=UDim2.new(0.5,0,0,-1) dtxt.BackgroundTransparency=1 dtxt.Font=Enum.Font.GothamBold dtxt.TextSize=8 dtxt.ZIndex=3 dtxt.Parent=dot
        radarDots[name]={dot=dot,txt=dtxt}
    end
    return radarDots[name]
end

local sheriffDropPos=nil
local lastSheriffName=nil
local RADAR_RANGE=150

local function worldToRadar(worldPos)
    local myChar=LocalPlayer.Character
    local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local diff=worldPos-myRoot.Position
    local forward=myRoot.CFrame.LookVector
    local right=myRoot.CFrame.RightVector
    local x=diff:Dot(right) local z=diff:Dot(forward)
    local nx=math.clamp(x/RADAR_RANGE,-1,1)*0.45+0.5
    local ny=math.clamp(-z/RADAR_RANGE,-1,1)*0.45+0.5
    return nx,ny
end

-- ANA GUI
local GUI=mount(Instance.new("ScreenGui"))
GUI.Name="MM2Ultimate" GUI.ResetOnSpawn=false GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling GUI.DisplayOrder=999

local GlowGui=Instance.new("Frame") GlowGui.Size=UDim2.new(0,570,0,510) GlowGui.Position=UDim2.new(0.5,-285,0.5,-255) GlowGui.BackgroundTransparency=1 GlowGui.ZIndex=0 GlowGui.Parent=GUI
local GlowImg=Instance.new("ImageLabel") GlowImg.Size=UDim2.new(1,60,1,60) GlowImg.Position=UDim2.new(0,-30,0,-30) GlowImg.BackgroundTransparency=1 GlowImg.Image="rbxassetid://5028857084" GlowImg.ImageColor3=T.Accent GlowImg.ImageTransparency=0.7 GlowImg.ScaleType=Enum.ScaleType.Slice GlowImg.SliceCenter=Rect.new(24,24,276,276) GlowImg.ZIndex=0 GlowImg.Parent=GlowGui

local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,540,0,500) Main.Position=UDim2.new(0.5,-270,0.5,-250)
Main.BackgroundColor3=T.BG Main.BorderSizePixel=0 Main.Active=true Main.Draggable=true
Main.Visible=false Main.ZIndex=1 Main.Parent=GUI
corner(Main,12) stroke(Main,T.Border,1)

local TitleBar=Instance.new("Frame") TitleBar.Size=UDim2.new(1,0,0,52) TitleBar.BackgroundColor3=T.Surface TitleBar.BorderSizePixel=0 TitleBar.ZIndex=2 TitleBar.Parent=Main corner(TitleBar,12)
local TFix=Instance.new("Frame") TFix.Size=UDim2.new(1,0,0.5,0) TFix.Position=UDim2.new(0,0,0.5,0) TFix.BackgroundColor3=T.Surface TFix.BorderSizePixel=0 TFix.Parent=TitleBar
local TG=Instance.new("UIGradient") TG.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(90,15,20)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(30,15,18)),ColorSequenceKeypoint.new(1,T.Surface)}) TG.Parent=TitleBar
local TU=Instance.new("Frame") TU.Size=UDim2.new(1,0,0,1) TU.Position=UDim2.new(0,0,1,-1) TU.BackgroundColor3=T.Accent TU.BorderSizePixel=0 TU.Parent=TitleBar
local TM=Instance.new("Frame") TM.Size=UDim2.new(0,4,0,20) TM.Position=UDim2.new(0,14,0.5,-10) TM.BackgroundColor3=T.Accent TM.BorderSizePixel=0 TM.Parent=TitleBar corner(TM,2)
lbl(TitleBar,"🔪  MM2 Ultimate",15,T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,26,0,9),UDim2.new(0.7,0,0,20))
lbl(TitleBar,"INSERT aç/kapat  ·  DELETE panic  ·  Radar sağ alt",10,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,26,0,30),UDim2.new(0.7,0,0,14))

local function titleBtn(x,txt,col,cb)
    local b=Instance.new("TextButton") b.Size=UDim2.new(0,28,0,28) b.Position=UDim2.new(1,x,0.5,-14) b.BackgroundColor3=col b.BackgroundTransparency=0.5 b.Text=txt b.TextColor3=T.Text b.Font=Enum.Font.GothamBold b.TextSize=13 b.BorderSizePixel=0 b.Parent=TitleBar corner(b,7)
    b.MouseEnter:Connect(function() tw(b,{BackgroundTransparency=0}) end)
    b.MouseLeave:Connect(function() tw(b,{BackgroundTransparency=0.5}) end)
    b.MouseButton1Click:Connect(cb) return b
end

titleBtn(-38,"✕",T.Bad,function() Main.Visible=false GlowGui.Visible=false end)

local minimized=false
local ContentWrapper=Instance.new("Frame") ContentWrapper.Size=UDim2.new(1,0,1,-52) ContentWrapper.Position=UDim2.new(0,0,0,52) ContentWrapper.BackgroundTransparency=1 ContentWrapper.ClipsDescendants=true ContentWrapper.Parent=Main

titleBtn(-72,"—",T.Warn,function()
    minimized=not minimized
    tw(Main,{Size=minimized and UDim2.new(0,540,0,52) or UDim2.new(0,540,0,500)},0.4,Enum.EasingStyle.Back)
end)

local TabBar=Instance.new("Frame") TabBar.Size=UDim2.new(1,0,0,38) TabBar.BackgroundColor3=Color3.fromRGB(14,14,17) TabBar.BorderSizePixel=0 TabBar.Parent=ContentWrapper
local TBL=Instance.new("UIListLayout") TBL.FillDirection=Enum.FillDirection.Horizontal TBL.Padding=UDim.new(0,2) TBL.VerticalAlignment=Enum.VerticalAlignment.Center TBL.Parent=TabBar
local TBP=Instance.new("UIPadding") TBP.PaddingLeft=UDim.new(0,8) TBP.PaddingTop=UDim.new(0,4) TBP.PaddingBottom=UDim.new(0,4) TBP.Parent=TabBar
local TBUnder=Instance.new("Frame") TBUnder.Size=UDim2.new(1,0,0,1) TBUnder.Position=UDim2.new(0,0,1,-1) TBUnder.BackgroundColor3=T.Border TBUnder.BorderSizePixel=0 TBUnder.Parent=TabBar

local ContentArea=Instance.new("Frame") ContentArea.Size=UDim2.new(1,0,1,-38) ContentArea.Position=UDim2.new(0,0,0,38) ContentArea.BackgroundTransparency=1 ContentArea.ClipsDescendants=true ContentArea.Parent=ContentWrapper

local StatusBar=Instance.new("Frame") StatusBar.Size=UDim2.new(1,0,0,26) StatusBar.AnchorPoint=Vector2.new(0,1) StatusBar.Position=UDim2.new(0,0,1,0) StatusBar.BackgroundColor3=Color3.fromRGB(14,14,17) StatusBar.BorderSizePixel=0 StatusBar.ZIndex=5 StatusBar.Parent=Main
local SBL=Instance.new("Frame") SBL.Size=UDim2.new(1,0,0,1) SBL.BackgroundColor3=T.Border SBL.BorderSizePixel=0 SBL.Parent=StatusBar
local SDot=Instance.new("Frame") SDot.Size=UDim2.new(0,6,0,6) SDot.Position=UDim2.new(0,12,0.5,-3) SDot.BackgroundColor3=T.Good SDot.BorderSizePixel=0 SDot.Parent=StatusBar corner(SDot,3)
local STxt=lbl(StatusBar,"Hazır",11,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,26,0,0),UDim2.new(0.6,0,1,0))
local SRight=lbl(StatusBar,"",11,T.Faint,Enum.Font.GothamMedium,Enum.TextXAlignment.Right,UDim2.new(0.4,0,0,0),UDim2.new(0.6,-12,1,0))

local function setStatus(txt,kind)
    STxt.Text=txt
    local col=kind=="ok" and T.Good or kind=="warn" and T.Warn or kind=="error" and T.Bad or T.Faint
    tw(SDot,{BackgroundColor3=col})
end

-- TAB SİSTEMİ
local tabs={} local activeTab=nil
local function makeTab(name,icon)
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(0,82,1,0) btn.BackgroundTransparency=1 btn.Text=icon.." "..name btn.TextColor3=T.Faint btn.Font=Enum.Font.GothamMedium btn.TextSize=11 btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.Parent=TabBar corner(btn,6)
    local ind=Instance.new("Frame") ind.Size=UDim2.new(0,0,0,2) ind.AnchorPoint=Vector2.new(0.5,1) ind.Position=UDim2.new(0.5,0,1,0) ind.BackgroundColor3=T.Accent ind.BorderSizePixel=0 ind.Parent=btn
    local scroll=Instance.new("ScrollingFrame") scroll.Size=UDim2.new(1,0,1,0) scroll.BackgroundTransparency=1 scroll.BorderSizePixel=0 scroll.CanvasSize=UDim2.new() scroll.AutomaticCanvasSize=Enum.AutomaticSize.Y scroll.ScrollBarThickness=3 scroll.ScrollBarImageColor3=T.Accent scroll.Visible=false scroll.Parent=ContentArea
    local sl=Instance.new("UIListLayout") sl.Padding=UDim.new(0,6) sl.Parent=scroll
    local sp=Instance.new("UIPadding") sp.PaddingLeft=UDim.new(0,12) sp.PaddingRight=UDim.new(0,12) sp.PaddingTop=UDim.new(0,10) sp.PaddingBottom=UDim.new(0,10) sp.Parent=scroll
    local tab={btn=btn,scroll=scroll,ind=ind}
    btn.MouseEnter:Connect(function() if activeTab~=tab then tw(btn,{TextColor3=T.Dim}) end end)
    btn.MouseLeave:Connect(function() if activeTab~=tab then tw(btn,{TextColor3=T.Faint}) end end)
    btn.MouseButton1Click:Connect(function()
        if activeTab then activeTab.scroll.Visible=false tw(activeTab.btn,{TextColor3=T.Faint}) tw(activeTab.ind,{Size=UDim2.new(0,0,0,2)},0.3) end
        activeTab=tab scroll.Visible=true tw(btn,{TextColor3=T.Text}) tw(ind,{Size=UDim2.new(1,-16,0,2)},0.3,Enum.EasingStyle.Back)
    end)
    tabs[name]=tab
    if not activeTab then activeTab=tab scroll.Visible=true btn.TextColor3=T.Text ind.Size=UDim2.new(1,-16,0,2) end
    return tab
end

-- KONTROL ÜRETİCİLER
local function makeSection(tab,title,icon)
    local card=Instance.new("Frame") card.Size=UDim2.new(1,0,0,0) card.AutomaticSize=Enum.AutomaticSize.Y card.BackgroundColor3=T.Surface card.BorderSizePixel=0 card.Parent=tab.scroll corner(card,10) stroke(card,T.Border,1)
    local cl=Instance.new("UIListLayout") cl.Padding=UDim.new(0,4) cl.Parent=card
    local cp=Instance.new("UIPadding") cp.PaddingLeft=UDim.new(0,10) cp.PaddingRight=UDim.new(0,10) cp.PaddingTop=UDim.new(0,10) cp.PaddingBottom=UDim.new(0,10) cp.Parent=card
    local hdr=Instance.new("Frame") hdr.Size=UDim2.new(1,0,0,24) hdr.BackgroundTransparency=1 hdr.Parent=card
    local mark=Instance.new("Frame") mark.Size=UDim2.new(0,3,0,16) mark.Position=UDim2.new(0,0,0.5,-8) mark.BackgroundColor3=T.Accent mark.BorderSizePixel=0 mark.Parent=hdr corner(mark,2)
    lbl(hdr,(icon or "").."  "..title:upper(),11,T.Accent,Enum.Font.GothamBold,Enum.TextXAlignment.Left,UDim2.new(0,10,0,0),UDim2.new(1,-10,1,0))
    local div=Instance.new("Frame") div.Size=UDim2.new(1,0,0,1) div.BackgroundColor3=T.Border div.BorderSizePixel=0 div.Parent=card
    return card
end

local function makeToggle(parent,name,desc,callback)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,desc and 48 or 36) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    lbl(row,name,13,T.Text,Enum.Font.GothamMedium,Enum.TextXAlignment.Left,UDim2.new(0,12,0,desc and 6 or 0),UDim2.new(0.75,0,0,18))
    if desc then lbl(row,desc,10,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,12,0,24),UDim2.new(0.75,0,0,14)) end
    local track=Instance.new("Frame") track.Size=UDim2.new(0,40,0,22) track.Position=UDim2.new(1,-50,0.5,-11) track.BackgroundColor3=Color3.fromRGB(45,45,52) track.BorderSizePixel=0 track.Parent=row corner(track,11)
    local knob=Instance.new("Frame") knob.Size=UDim2.new(0,16,0,16) knob.Position=UDim2.new(0,3,0.5,-8) knob.BackgroundColor3=T.Dim knob.BorderSizePixel=0 knob.Parent=track corner(knob,8)
    local on=false
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,1,0) btn.BackgroundTransparency=1 btn.Text="" btn.Parent=row
    local h={}
    function h:get() return on end
    function h:set(v,fire)
        on=v
        tw(track,{BackgroundColor3=on and T.Accent or Color3.fromRGB(45,45,52)})
        tw(knob,{Position=on and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),BackgroundColor3=on and T.Text or T.Dim},0.25,Enum.EasingStyle.Back)
        if fire~=false then pcall(callback,on) end
    end
    row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=T.SurfaceHi}) end)
    row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=T.BG}) end)
    btn.MouseButton1Click:Connect(function() h:set(not on) end)
    return h
end

local function makeButton(parent,name,col,cb)
    local btn=Instance.new("TextButton") btn.Size=UDim2.new(1,0,0,34) btn.BackgroundColor3=col or T.AccentDark btn.Text=name btn.TextColor3=T.Text btn.Font=Enum.Font.GothamMedium btn.TextSize=13 btn.BorderSizePixel=0 btn.AutoButtonColor=false btn.Parent=parent corner(btn,8) stroke(btn,col or T.Accent,1)
    local bc=col or T.AccentDark
    btn.MouseEnter:Connect(function() tw(btn,{BackgroundColor3=T.Accent}) end)
    btn.MouseLeave:Connect(function() tw(btn,{BackgroundColor3=bc}) end)
    btn.MouseButton1Down:Connect(function() tw(btn,{BackgroundColor3=Color3.fromRGB(80,0,0)}) end)
    btn.MouseButton1Up:Connect(function() tw(btn,{BackgroundColor3=T.Accent}) end)
    btn.MouseButton1Click:Connect(function() pcall(cb) end)
    return btn
end

local function makeSlider(parent,name,min,max,default,suffix,callback)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,52) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    lbl(row,name,13,T.Text,Enum.Font.GothamMedium,Enum.TextXAlignment.Left,UDim2.new(0,12,0,8),UDim2.new(0.7,0,0,16))
    local vl=lbl(row,tostring(default)..(suffix or ""),12,T.Accent,Enum.Font.GothamBold,Enum.TextXAlignment.Right,UDim2.new(0.65,0,0,8),UDim2.new(0.35,-12,0,16))
    local track=Instance.new("Frame") track.Size=UDim2.new(1,-24,0,5) track.Position=UDim2.new(0,12,0,36) track.BackgroundColor3=Color3.fromRGB(35,35,42) track.BorderSizePixel=0 track.Parent=row corner(track,3)
    local fill=Instance.new("Frame") fill.BackgroundColor3=T.Accent fill.BorderSizePixel=0 fill.Size=UDim2.new((default-min)/(max-min),0,1,0) fill.Parent=track corner(fill,3)
    local knob=Instance.new("Frame") knob.Size=UDim2.new(0,13,0,13) knob.AnchorPoint=Vector2.new(0.5,0.5) knob.Position=UDim2.new((default-min)/(max-min),0,0.5,0) knob.BackgroundColor3=T.Text knob.BorderSizePixel=0 knob.ZIndex=3 knob.Parent=track corner(knob,7)
    local value=default local grabbing=false
    local function setFromX(x)
        local alpha=math.clamp((x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1),0,1)
        value=math.floor(min+(max-min)*alpha+0.5) vl.Text=tostring(value)..(suffix or "")
        tw(fill,{Size=UDim2.new(alpha,0,1,0)},0.1) tw(knob,{Position=UDim2.new(alpha,0,0.5,0)},0.1) pcall(callback,value)
    end
    local hit=Instance.new("TextButton") hit.Size=UDim2.new(1,0,0,22) hit.Position=UDim2.new(0,0,0,28) hit.BackgroundTransparency=1 hit.Text="" hit.Parent=row
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then grabbing=true setFromX(i.Position.X) end end)
    UserInputService.InputChanged:Connect(function(i) if grabbing and i.UserInputType==Enum.UserInputType.MouseMovement then setFromX(i.Position.X) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then grabbing=false end end)
    row.MouseEnter:Connect(function() tw(row,{BackgroundColor3=T.SurfaceHi}) end)
    row.MouseLeave:Connect(function() tw(row,{BackgroundColor3=T.BG}) end)
    return{get=function() return value end}
end

local function makeLiveLabel(parent,text,valueText,valueColor)
    local row=Instance.new("Frame") row.Size=UDim2.new(1,0,0,32) row.BackgroundColor3=T.BG row.BorderSizePixel=0 row.Parent=parent corner(row,8)
    lbl(row,text,12,T.Dim,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,12,0,0),UDim2.new(0.5,0,1,0))
    local val=lbl(row,valueText or "—",12,valueColor or T.Text,Enum.Font.GothamBold,Enum.TextXAlignment.Right,UDim2.new(0.5,0,0,0),UDim2.new(0.5,-12,1,0))
    return{set=function(txt,col) val.Text=tostring(txt) if col then val.TextColor3=col end end}
end

-- ROL TESPİT
local function getPlayerRole(player)
    if not player or not player.Character then return "innocent" end
    local activeTool=player.Character:FindFirstChildWhichIsA("Tool")
    if activeTool then
        local tn=activeTool.Name:lower()
        if tn:find("knife") or tn:find("blade") or tn:find("murder") or tn:find("sword") then return "murderer"
        elseif tn:find("gun") or tn:find("sheriff") or tn:find("revolver") or tn:find("pistol") then return "sheriff" end
    end
    local backpack=player:FindFirstChild("Backpack")
    if backpack then
        for _,item in pairs(backpack:GetChildren()) do
            if item:IsA("Tool") then
                local tn=item.Name:lower()
                if tn:find("knife") or tn:find("blade") or tn:find("murder") then return "murderer"
                elseif tn:find("gun") or tn:find("sheriff") or tn:find("revolver") then return "sheriff" end
            end
        end
    end
    local ls=player:FindFirstChild("leaderstats") or player:FindFirstChild("GameStats")
    if ls then
        local role=ls:FindFirstChild("Role") or ls:FindFirstChild("Team")
        if role then
            local rv=tostring(role.Value):lower()
            if rv:find("murd") or rv:find("killer") then return "murderer"
            elseif rv:find("sheriff") or rv:find("hero") then return "sheriff" end
        end
    end
    for _,obj in pairs(player.Character:GetDescendants()) do
        local n=obj.Name:lower()
        if n:find("knife") or n:find("blade") then return "murderer"
        elseif n:find("sheriff") or n:find("gun") then return "sheriff" end
    end
    return "innocent"
end

-- TABLAR
local tInfo=makeTab("Bilgi","📊")
local tESP=makeTab("ESP","👁")
local tAim=makeTab("Aim","🎯")
local tMove=makeTab("Hareket","🏃")
local tWeap=makeTab("Silah","⚔️")
local tGame=makeTab("Oyun","🎮")

-- BİLGİ TABU
local secRoles=makeSection(tInfo,"Rol Bilgisi","🎭")
local lblMurd=makeLiveLabel(secRoles,"🔪 Katil","Tespit ediliyor...",T.Murd)
local lblSher=makeLiveLabel(secRoles,"🔫 Şerif","Tespit ediliyor...",T.Sher)
local lblMyRole=makeLiveLabel(secRoles,"👤 Senin Rolün","?",T.Text)
local lblSherDrop=makeLiveLabel(secRoles,"📍 Şerif Silah Yeri","Henüz düşmedi",T.Sher)

local secStats=makeSection(tInfo,"İstatistikler","📈")
local lblPlayers=makeLiveLabel(secStats,"Oyuncu Sayısı","0")
local lblAlive=makeLiveLabel(secStats,"Hayatta","0")
local lblDead=makeLiveLabel(secStats,"Ölü","0")
local lblPing=makeLiveLabel(secStats,"Ping","?")
local lblFPS=makeLiveLabel(secStats,"FPS","?")

local secRadarCtrl=makeSection(tInfo,"Radar","📡")
local radarTog=makeToggle(secRadarCtrl,"Radar Göster","Sağ altta mini harita")
local radarRange=makeSlider(secRadarCtrl,"Radar Menzili",50,400,150," st",function(v) RADAR_RANGE=v end)
makeButton(secRadarCtrl,"🔄 Şerif Silah Yerini Sıfırla",Color3.fromRGB(30,30,60),function()
    sheriffDropPos=nil SheriffDropMarker.Visible=false SheriffDropLabel.Visible=false
    lblSherDrop.set("Henüz düşmedi",T.Faint)
    notify("Radar","Şerif silah yeri sıfırlandı","info")
end)

-- ESP TABU
local secESP=makeSection(tESP,"ESP","👁")
local espMurd=makeToggle(secESP,"Katil ESP","Kırmızı — backpack dahil")
local espSher=makeToggle(secESP,"Şerif ESP","Sarı — backpack dahil")
local espInno=makeToggle(secESP,"Masum ESP","Mavi")
local espDead=makeToggle(secESP,"Ölü ESP","Hayaletler")
local espChams=makeToggle(secESP,"Chams","Duvardan renk")
local espDist=makeToggle(secESP,"Mesafe Göster")

-- AIM TABU
local secAim=makeSection(tAim,"Aimbot","🎯")
local autoAim=makeToggle(secAim,"Auto-Aim","Şerif silahıyla katile nişan")
local autoShoot=makeToggle(secAim,"Auto-Shoot","Otomatik ateş")
local showFOV=makeToggle(secAim,"FOV Dairesi")
local aimSmooth=makeSlider(secAim,"Pürüzsüzlük",1,20,8,"x",function() end)
local aimFOV=makeSlider(secAim,"FOV (px)",20,400,100,"px",function() end)

local FOVGUI=mount(Instance.new("ScreenGui"))
FOVGUI.Name="MM2FOV" FOVGUI.ResetOnSpawn=false FOVGUI.DisplayOrder=998
local FOVFrame=Instance.new("Frame") FOVFrame.BackgroundTransparency=1 FOVFrame.Size=UDim2.new(0,200,0,200) FOVFrame.Position=UDim2.new(0.5,-100,0.5,-100) FOVFrame.Parent=FOVGUI FOVFrame.Visible=false
local FOVImg=Instance.new("ImageLabel") FOVImg.Size=UDim2.new(1,0,1,0) FOVImg.BackgroundTransparency=1 FOVImg.Image="rbxassetid://3570695787" FOVImg.ImageColor3=T.Accent FOVImg.ImageTransparency=0.5 FOVImg.Parent=FOVFrame

-- HAREKET TABU
local secFly=makeSection(tMove,"Uçuş","✈️")
local flyTog=makeToggle(secFly,"Uçma","WASD + Space/Shift")
local flySpeed=makeSlider(secFly,"Uçuş Hızı",10,200,60," sp",function() end)
local secWalk=makeSection(tMove,"Yürüyüş","🏃")
local speedTog=makeToggle(secWalk,"Hız Hilesi")
local speedVal=makeSlider(secWalk,"Hız",16,200,60," sp",function() end)
local noclipTog=makeToggle(secWalk,"NoClip","Duvarlardan geç")
local bhopTog=makeToggle(secWalk,"BunnyHop")
local secTP=makeSection(tMove,"Işınlanma","📍")

makeButton(secTP,"📍 Katile Işınlan",T.AccentDark,function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            if getPlayerRole(p)=="murderer" then
                local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local t=p.Character:FindFirstChild("HumanoidRootPart")
                if r and t then r.CFrame=t.CFrame+Vector3.new(5,0,0) notify("Işınlandı","Katile: "..p.Name,"warn") end
            end
        end
    end
end)
makeButton(secTP,"📍 Şerife Işınlan",Color3.fromRGB(100,70,0),function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            if getPlayerRole(p)=="sheriff" then
                local r=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local t=p.Character:FindFirstChild("HumanoidRootPart")
                if r and t then r.CFrame=t.CFrame+Vector3.new(5,0,0) notify("Işınlandı","Şerife: "..p.Name,"info") end
            end
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

-- SİLAH TABU
local secFakeW=makeSection(tWeap,"Görsel Silahlar","⚔️")
lbl(secFakeW,"Sadece sen görebilirsin",11,T.Faint,Enum.Font.Gotham,Enum.TextXAlignment.Left,UDim2.new(0,0,0,0),UDim2.new(1,0,0,20))
local fakeWeapons={}

local function makeFake(color,size,neon)
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    local char=LocalPlayer.Character if not char then return end
    local hand=char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") if not hand then return end
    local m=Instance.new("Model") m.Parent=workspace
    local b=Instance.new("Part") b.Size=size or Vector3.new(0.1,0.82,0.09) b.Color=color b.Material=neon and Enum.Material.Neon or Enum.Material.SmoothPlastic b.CanCollide=false b.Anchored=false b.CastShadow=false b.Parent=m
    local w=Instance.new("WeldConstraint") w.Part0=b w.Part1=hand w.Parent=b b.CFrame=hand.CFrame*CFrame.new(0,-0.5,-0.2)
    fakeWeapons.active=m
end

makeButton(secFakeW,"🗡 Standart Bıçak",T.AccentDark,function() makeFake(Color3.fromRGB(200,200,215)) notify("Silah","Standart bıçak","success") end)
makeButton(secFakeW,"✨ Altın Bıçak",Color3.fromRGB(100,70,0),function() makeFake(Color3.fromRGB(255,200,0),nil,true) notify("Silah","Altın bıçak","success") end)
makeButton(secFakeW,"💎 Kristal Bıçak",Color3.fromRGB(0,50,100),function() makeFake(Color3.fromRGB(100,200,255),nil,true) notify("Silah","Kristal bıçak","success") end)
makeButton(secFakeW,"🟣 Mor Bıçak",Color3.fromRGB(60,0,100),function() makeFake(Color3.fromRGB(180,50,255),nil,true) notify("Silah","Mor bıçak","success") end)
makeButton(secFakeW,"🔴 Kırmızı Bıçak",T.AccentDark,function() makeFake(Color3.fromRGB(255,30,30),nil,true) notify("Silah","Kırmızı bıçak","success") end)
makeButton(secFakeW,"🔫 Şerif Silahı",Color3.fromRGB(30,30,50),function()
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    local char=LocalPlayer.Character if not char then return end
    local hand=char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm") if not hand then return end
    local m=Instance.new("Model") m.Parent=workspace
    local barrel=Instance.new("Part") barrel.Size=Vector3.new(0.1,0.1,0.6) barrel.Color=Color3.fromRGB(55,55,62) barrel.Material=Enum.Material.Metal barrel.CanCollide=false barrel.Anchored=false barrel.Parent=m
    local handle2=Instance.new("Part") handle2.Size=Vector3.new(0.1,0.3,0.1) handle2.Color=Color3.fromRGB(80,40,20) handle2.Material=Enum.Material.Wood handle2.CanCollide=false handle2.Anchored=false handle2.Parent=m
    local w1=Instance.new("WeldConstraint") w1.Part0=barrel w1.Part1=hand w1.Parent=barrel barrel.CFrame=hand.CFrame*CFrame.new(0,0,-0.32)
    local w2=Instance.new("WeldConstraint") w2.Part0=handle2 w2.Part1=hand w2.Parent=handle2 handle2.CFrame=hand.CFrame*CFrame.new(0,-0.2,-0.1)
    fakeWeapons.active=m notify("Silah","Şerif silahı","success")
end)
makeButton(secFakeW,"❌ Kaldır",Color3.fromRGB(40,15,15),function()
    if fakeWeapons.active then fakeWeapons.active:Destroy() fakeWeapons.active=nil end
    notify("Silah","Kaldırıldı","info")
end)

-- OYUN TABU
local secGameOpts=makeSection(tGame,"Oyun","🎮")
local antiVoid=makeToggle(secGameOpts,"Anti-Void","Void'den kurtarır")
local autoCoin=makeToggle(secGameOpts,"Auto Coin","Altın topla")
local fullbright=makeToggle(secGameOpts,"Fullbright","Karanlığı kaldır")
local rainbow=makeToggle(secGameOpts,"Gökkuşağı","Renk değişimi")
local chatSpam=makeToggle(secGameOpts,"Chat Spam","Otomatik mesaj")
local chatMsgs={"gg","ez","nice","lol","xd"}
local chatIdx=1

makeButton(secGameOpts,"💰 Altına Işınlan",T.AccentDark,function()
    local myChar=LocalPlayer.Character local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart") if not myRoot then return end
    local closest,closestDist=nil,math.huge
    for _,obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
            local dist=(obj.Position-myRoot.Position).Magnitude if dist<closestDist then closest=obj closestDist=dist end
        end
    end
    if closest then myRoot.CFrame=CFrame.new(closest.Position+Vector3.new(0,3,0)) notify("Altın","Işınlandın!","success")
    else notify("Altın","Bulunamadı","warn") end
end)

-- DEĞİŞKENLER
local flyBV,flyBG=nil,nil
local safePos=Vector3.new(0,5,0)
local detectedMurderer,detectedSheriff=nil,nil
local lastMurdNotify=0
local allToggles={espMurd,espSher,espInno,espDead,espChams,espDist,autoAim,autoShoot,showFOV,flyTog,speedTog,noclipTog,bhopTog,antiVoid,autoCoin,fullbright,rainbow,radarTog,chatSpam}

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

-- INSERT / DELETE
UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode==Enum.KeyCode.Insert then
        Main.Visible=not Main.Visible GlowGui.Visible=Main.Visible
        if Main.Visible then Main.GroupTransparency=1 tw(Main,{GroupTransparency=0},0.3) end
    end
    if input.KeyCode==Enum.KeyCode.Delete then
        for _,t in pairs(allToggles) do pcall(function() t:set(false) end) end
        flyCallback(false)
        if fakeWeapons.active then fakeWeapons.active:Destroy() fakeWeapons.active=nil end
        game:GetService("Lighting").Brightness=1
        notify("PANIC","Tüm hileler kapatıldı!","error")
        setStatus("Panic","warn")
    end
end)

-- ANA DÖNGÜ
local fpsCount,fpsAccum,chatTimer=0,0,0

RunService.Heartbeat:Connect(function(dt)
    fpsCount+=1 fpsAccum+=dt chatTimer+=dt
    if fpsAccum>=1 then lblFPS.set(math.floor(fpsCount/fpsAccum).." FPS") fpsCount=0 fpsAccum=0 end

    local char=LocalPlayer.Character if not char then return end
    local hum=char:FindFirstChild("Humanoid")
    local root=char:FindFirstChild("HumanoidRootPart")

    if root and root.Position.Y>-50 then safePos=root.Position end
    if antiVoid:get() and root and root.Position.Y<-100 then
        root.CFrame=CFrame.new(safePos+Vector3.new(0,5,0)) notify("Anti-Void","Kurtarıldın!","warn")
    end

    if speedTog:get() and hum then hum.WalkSpeed=speedVal.get() end
    if noclipTog:get() then for _,p in pairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
    if bhopTog:get() and hum then if hum.FloorMaterial~=Enum.Material.Air then hum.Jump=true end end

    if flyTog:get() then
        if not flyBV or not flyBV.Parent then flyCallback(true) end
        if flyBV and flyBG then
            local d=Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then d+=Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then d-=Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then d-=Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then d+=Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then d+=Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.new(0,1,0) end
            flyBV.Velocity=d.Magnitude>0 and d.Unit*flySpeed.get() or Vector3.zero
            flyBG.CFrame=Camera.CFrame
        end
    else
        if flyBV then flyCallback(false) end
    end

    if fullbright:get() then game:GetService("Lighting").Brightness=10 game:GetService("Lighting").FogEnd=1e6 end
    if rainbow:get() then
        local color=Color3.fromHSV(tick()%5/5,1,1)
        for _,p in pairs(char:GetDescendants()) do pcall(function() if p:IsA("BasePart") then p.Color=color end end) end
    end

    if chatSpam:get() and chatTimer>3 then
        chatTimer=0
        pcall(function()
            chatIdx=chatIdx%#chatMsgs+1
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatMsgs[chatIdx],"All")
        end)
    end

    -- ROL TESPİTİ
    local murdName,sherName=nil,nil
    local aliveCount,deadCount=0,0

    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hum2=p.Character:FindFirstChild("Humanoid")
            if hum2 then if hum2.Health>0 then aliveCount+=1 else deadCount+=1 end end
            if p~=LocalPlayer then
                local role=getPlayerRole(p)
                if role=="murderer" then murdName=p.Name
                elseif role=="sheriff" then sherName=p.Name end
            end
        end
    end

    -- Şerif ölünce silah yeri kaydet
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            local hum2=p.Character:FindFirstChild("Humanoid")
            local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
            local wasSheriff=lastSheriffName==p.Name
            if wasSheriff and hum2 and hum2.Health<=0 and not sheriffDropPos and pRoot then
                sheriffDropPos=pRoot.Position
                SheriffDropMarker.Visible=true SheriffDropLabel.Visible=true
                SheriffDropLabel.Text="🔫 "..p.Name
                lblSherDrop.set("📍 "..math.floor(pRoot.Position.X)..","..math.floor(pRoot.Position.Y)..","..math.floor(pRoot.Position.Z),T.Sher)
                notify("⚠️ ŞERİF ÖLDÜ!",p.Name.."'nin silahı burada!","warn",8)
            end
        end
    end

    if sherName then lastSheriffName=sherName end

    local myRole=getPlayerRole(LocalPlayer)
    local myRoleText=myRole=="murderer" and "🔪 KATİL" or myRole=="sheriff" and "🔫 ŞERİF" or "👤 MASUM"
    local myRoleColor=myRole=="murderer" and T.Murd or myRole=="sheriff" and T.Sher or T.Inno
    lblMyRole.set(myRoleText,myRoleColor)

    if murdName and murdName~=detectedMurderer then
        detectedMurderer=murdName
        if tick()-lastMurdNotify>8 then notify("⚠️ KATİL!",murdName.." katil!","error",6) lastMurdNotify=tick() end
    end
    if not murdName then detectedMurderer=nil end
    detectedSheriff=sherName

    lblMurd.set(detectedMurderer or "Bilinmiyor",detectedMurderer and T.Murd or T.Faint)
    lblSher.set(detectedSheriff or "Bilinmiyor",detectedSheriff and T.Sher or T.Faint)
    lblPlayers.set(#Players:GetPlayers()) lblAlive.set(aliveCount,T.Good) lblDead.set(deadCount,T.Bad)

    pcall(function()
        local ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        lblPing.set(math.floor(ping).."ms",ping<80 and T.Good or ping<150 and T.Warn or T.Bad)
    end)

    SRight.Text=aliveCount.." hayatta"..(detectedMurderer and " · 🔪 "..detectedMurderer or "")

    if sheriffDropPos then
        local myR=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if myR then
            local dist=math.floor((sheriffDropPos-myR.Position).Magnitude)
            SheriffDropLabel.Text="🔫 "..dist.." st uzakta"
        end
    end

    -- ESP
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LocalPlayer and p.Character then
            local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
            if pRoot then
                local role=getPlayerRole(p)
                local pHum=p.Character:FindFirstChild("Humanoid")
                local isDead=pHum and pHum.Health<=0
                local showESP=(role=="murderer" and espMurd:get()) or (role=="sheriff" and espSher:get()) or (role=="innocent" and espInno:get()) or (isDead and espDead:get())
                local bb=pRoot:FindFirstChild("_mm2esp")

                if showESP then
                    if not bb then
                        bb=Instance.new("BillboardGui") bb.Name="_mm2esp" bb.Size=UDim2.new(0,150,0,60) bb.StudsOffset=Vector3.new(0,4.5,0) bb.AlwaysOnTop=true bb.Parent=pRoot
                        local bg=Instance.new("Frame") bg.Name="BG" bg.Size=UDim2.new(1,0,1,0) bg.BackgroundColor3=Color3.fromRGB(10,10,13) bg.BackgroundTransparency=0.3 bg.BorderSizePixel=0 bg.Parent=bb corner(bg,6)
                        local nl2=Instance.new("TextLabel") nl2.Name="NL" nl2.Size=UDim2.new(1,-10,0,22) nl2.Position=UDim2.new(0,5,0,4) nl2.BackgroundTransparency=1 nl2.Font=Enum.Font.GothamBold nl2.TextSize=14 nl2.TextStrokeTransparency=0 nl2.TextXAlignment=Enum.TextXAlignment.Left nl2.Parent=bg
                        local rl2=Instance.new("TextLabel") rl2.Name="RL" rl2.Size=UDim2.new(1,-10,0,14) rl2.Position=UDim2.new(0,5,0,26) rl2.BackgroundTransparency=1 rl2.Font=Enum.Font.GothamBold rl2.TextSize=11 rl2.TextStrokeTransparency=0 rl2.TextXAlignment=Enum.TextXAlignment.Left rl2.Parent=bg
                        local dl2=Instance.new("TextLabel") dl2.Name="DL" dl2.Size=UDim2.new(1,-10,0,12) dl2.Position=UDim2.new(0,5,0,42) dl2.BackgroundTransparency=1 dl2.Font=Enum.Font.Gotham dl2.TextSize=10 dl2.TextStrokeTransparency=0.3 dl2.TextXAlignment=Enum.TextXAlignment.Left dl2.Parent=bg
                        local sb=Instance.new("Frame") sb.Name="SB" sb.Size=UDim2.new(0,3,1,-8) sb.Position=UDim2.new(0,0,0,4) sb.BorderSizePixel=0 sb.Parent=bg corner(sb,2)
                    end
                    local color=role=="murderer" and T.Murd or role=="sheriff" and T.Sher or isDead and T.Faint or T.Inno
                    local roleText=role=="murderer" and "🔪 KATİL" or role=="sheriff" and "🔫 ŞERİF" or isDead and "💀 ÖLÜ" or "👤 MASUM"
                    local bg=bb:FindFirstChild("BG")
                    if bg then
                        local nl2=bg:FindFirstChild("NL") local rl2=bg:FindFirstChild("RL") local dl2=bg:FindFirstChild("DL") local sb=bg:FindFirstChild("SB")
                        if nl2 then nl2.Text=p.Name nl2.TextColor3=color end
                        if rl2 then rl2.Text=roleText rl2.TextColor3=color end
                        if sb then sb.BackgroundColor3=color end
                        if dl2 and espDist:get() then
                            local myR=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if myR then
                                local dist=math.floor((pRoot.Position-myR.Position).Magnitude)
                                dl2.Text="📏 "..dist.." studs" dl2.TextColor3=dist<20 and T.Bad or dist<50 and T.Warn or T.Dim
                            end
                        elseif dl2 then dl2.Text="" end
                    end
                else
                    if bb then bb:Destroy() end
                end

                if espChams:get() then
                    for _,part in pairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") and not part:FindFirstChild("_chams") then
                            local sel=Instance.new("SelectionBox") sel.Name="_chams" sel.Adornee=part
                            local col=role=="murderer" and T.Murd or role=="sheriff" and T.Sher or T.Inno
                            sel.Color3=col sel.SurfaceColor3=col sel.SurfaceTransparency=0.7 sel.LineThickness=0.04 sel.Parent=part
                        end
                    end
                else
                    for _,part in pairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") then local s=part:FindFirstChild("_chams") if s then s:Destroy() end end
                    end
                end
            end
        end
    end

    -- Auto-aim
    if autoAim:get() and root then
        local myTool=char:FindFirstChildWhichIsA("Tool")
        local myTN=myTool and myTool.Name:lower() or ""
        local hasGun=myTN:find("gun") or myTN:find("sheriff") or myTN:find("revolver")
        if hasGun and detectedMurderer then
            local murdChar=Players:FindFirstChild(detectedMurderer) and Players:FindFirstChild(detectedMurderer).Character
            if murdChar then
                local murdRoot=murdChar:FindFirstChild("HumanoidRootPart") or murdChar:FindFirstChild("UpperTorso")
                if murdRoot then
                    local screenPos,onScreen=Camera:WorldToViewportPoint(murdRoot.Position)
                    if onScreen then
                        local center=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
                        local diff=Vector2.new(screenPos.X,screenPos.Y)-center
                        if diff.Magnitude<=aimFOV.get() then
                            local targetCF=CFrame.lookAt(Camera.CFrame.Position,murdRoot.Position)
                            Camera.CFrame=Camera.CFrame:Lerp(targetCF,dt*aimSmooth.get())
                            if autoShoot:get() then pcall(function() mouse1press() task.delay(0.1,mouse1release) end) end
                        end
                    end
                end
            end
        end
    end

    FOVFrame.Visible=showFOV:get() and autoAim:get()
    if FOVFrame.Visible then local fov=aimFOV.get()*2 FOVFrame.Size=UDim2.new(0,fov,0,fov) FOVFrame.Position=UDim2.new(0.5,-fov/2,0.5,-fov/2) end

    if autoCoin:get() then
        local myRoot2=char:FindFirstChild("HumanoidRootPart")
        if myRoot2 then
            local closest2,closestDist2=nil,35
            for _,obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("gold")) then
                    local dist=(obj.Position-myRoot2.Position).Magnitude if dist<closestDist2 then closest2=obj closestDist2=dist end
                end
            end
            if closest2 then myRoot2.CFrame=CFrame.new(closest2.Position+Vector3.new(0,3,0)) end
        end
    end

    -- RADAR
    RadarFrame.Visible=radarTog:get()
    if radarTog:get() then
        for name,data in pairs(radarDots) do data.dot.Visible=false end
        local myRoot=char:FindFirstChild("HumanoidRootPart")
        if myRoot then
            for _,p in pairs(Players:GetPlayers()) do
                if p~=LocalPlayer and p.Character then
                    local pRoot=p.Character:FindFirstChild("HumanoidRootPart")
                    if pRoot then
                        local nx,ny=worldToRadar(pRoot.Position)
                        if nx and ny then
                            local role=getPlayerRole(p)
                            local col=role=="murderer" and T.Murd or role=="sheriff" and T.Sher or T.Inno
                            local dot=getOrCreateDot(p.Name)
                            dot.dot.Visible=true dot.dot.Position=UDim2.new(nx,-5,ny,-5) dot.dot.BackgroundColor3=col
                            dot.txt.Text=p.Name:sub(1,6) dot.txt.TextColor3=col
                        end
                    end
                end
            end
            if sheriffDropPos then
                local nx,ny=worldToRadar(sheriffDropPos)
                if nx and ny then
                    SheriffDropMarker.Position=UDim2.new(nx,-7,ny,-7) SheriffDropLabel.Position=UDim2.new(nx,-40,ny,-22)
                    SheriffDropMarker.BackgroundTransparency=math.abs(math.sin(tick()*3))*0.5
                end
            end
        end
    end
end)

_G.__MM2_Destroy=function()
    pcall(function() GUI:Destroy() end) pcall(function() NotifyGui:Destroy() end)
    pcall(function() FOVGUI:Destroy() end) pcall(function() RadarGui:Destroy() end)
    if fakeWeapons.active then pcall(function() fakeWeapons.active:Destroy() end) end
    flyCallback(false)
end

setStatus("MM2 Ultimate yüklendi ✓","ok")
notify("MM2 Ultimate","INSERT aç/kapat · DELETE panic · Radar sağ altta!","success",6)
