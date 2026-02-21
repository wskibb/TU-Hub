local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local uivisible = true
local RunService = game:GetService("RunService")
local CursorConnection
local mouse = player:GetMouse()

local UI = {}

--------------------------------------------------
-- ScreenGui
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "TU-Hub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--------------------------------------------------
-- Main Frame
--------------------------------------------------

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 750, 0, 500)
main.Position = UDim2.new(0.5, -375, 0.5, -300)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 0
main.Parent = gui

-- leicht eckig, nicht „bubble“
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 6)
mainCorner.Parent = main

--------------------------------------------------
-- Top Bar (ziehbar)
--------------------------------------------------

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 36)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.BorderSizePixel = 0
topBar.Parent = main

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 6)
topCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -12, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TU-Hub"
title.TextXAlignment = "Left"
title.TextColor3 = Color3.fromRGB(147, 0, 221)
title.Font = Enum.Font.SourceSansSemibold
title.TextSize = 18
title.TextStrokeTransparency = 0
title.Parent = topBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.08, 0, 0.6, 0)
CloseButton.Position = UDim2.new(0.9,0,0.2,0)
CloseButton.BackgroundTransparency = 1
CloseButton.TextColor3 = Color3.fromRGB(255,0,0)
CloseButton.Text = "x"
CloseButton.TextSize = 12
CloseButton.Parent = topBar

local HideButton = Instance.new("TextButton")
HideButton.Size = UDim2.new(0.08, 0, 0.6, 0)
HideButton.Position = UDim2.new(0.8,0,0.2,0)
HideButton.BackgroundTransparency = 1
HideButton.TextColor3 = Color3.fromRGB(255,255,255)
HideButton.Text = "-"
HideButton.TextSize = 20
HideButton.Parent = topBar

--------------------------------------------------
-- Close/Hide Logic
--------------------------------------------------

local function EnableCursor()
	if not gui then return end

	uivisible = true

	UIS.MouseIconEnabled = true
	UIS.MouseBehavior = Enum.MouseBehavior.Default

	CursorConnection = RunService.RenderStepped:Connect(function()
		if uivisible then
			UIS.MouseIconEnabled = true
			UIS.MouseBehavior = Enum.MouseBehavior.Default
		end
	end)
end	


local function DisableCursor()
	uivisible = false

	if CursorConnection then
		CursorConnection:Disconnect()
		CursorConnection = nil
	end

	UIS.MouseIconEnabled = false
	UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
end

function UI:CloseButton(callback)
	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.new(0.08, 0, 0.6, 0)
	CloseButton.Position = UDim2.new(0.9,0,0.2,0)
	CloseButton.BackgroundTransparency = 1
	CloseButton.TextColor3 = Color3.fromRGB(255,0,0)
	CloseButton.Text = "x"
	CloseButton.TextSize = 12
	CloseButton.Parent = topBar

	

	CloseButton.MouseButton1Click:Connect(function()  
		callback()
		gui:Destroy()
		DisableCursor()
	end)
end 

local function Hide()
	gui.Enabled = false
	uivisible = false
	DisableCursor()
end



HideButton.MouseButton1Click:Connect(Hide)

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightShift then

		if uivisible then
			gui.Enabled = false
			DisableCursor()
		else 
			gui.Enabled = true
			EnableCursor()
		end
	end
end)

--------------------------------------------------
-- Drag Logic (Top Bar)
--------------------------------------------------

local dragging = false
local dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--------------------------------------------------
-- Sidebar (Tabs)
--------------------------------------------------

local sidebar = Instance.new("Frame")
sidebar.Position = UDim2.new(0, 0, 0, 36)
sidebar.Size = UDim2.new(0, 130, 1, -36)
sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 10)
tabLayout.Parent = sidebar

local tabPadding = Instance.new("UIPadding")
tabPadding.Parent = sidebar
tabPadding.PaddingTop = UDim.new(0, 10)
tabPadding.PaddingLeft = UDim.new(0, 10)
tabPadding.PaddingRight = UDim.new(0, 10)

--------------------------------------------------
-- Content Area
--------------------------------------------------

local pages = Instance.new("Folder")
pages.Name = "Pages"
pages.Parent = main

local contentFrame = Instance.new("Frame")
contentFrame.Position = UDim2.new(0, 130, 0, 36)
contentFrame.Size = UDim2.new(1, -130, 1, -36)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = main

--------------------------------------------------
-- Page Creator
--------------------------------------------------

local function createPage(name)
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = contentFrame

	local label = Instance.new("TextLabel")
	label.LayoutOrder = -1
	label.Size = UDim2.new(1, -20, 0, 30)
	label.Position = UDim2.new(0, 20, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(147, 0, 221)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 22
	label.TextXAlignment = "Left"
	label.Parent = page

	local pagecontainer = Instance.new("Frame")
	pagecontainer.Name = "Container"
	pagecontainer.Size = UDim2.new(0,600,0,390)
	pagecontainer.BackgroundTransparency = 1
	pagecontainer.Position = UDim2.new(0.03,0,0.16,0)
	pagecontainer.Parent = page

	local pagelayout = Instance.new("UIListLayout")
	pagelayout.Padding = UDim.new(0, 30)
	pagelayout.Parent = pagecontainer

	return page, pagecontainer

end

--------------------------------------------------
-- Toggle Button Creator
--------------------------------------------------

function UI:addToggleButton(name, page, LayoutOrder, callback)

	local btn = Instance.new("ImageButton")
	btn.LayoutOrder = LayoutOrder
	btn.Size = UDim2.new(0, 15, 0, 15)
	btn.Parent = page.Container
	btn.Name = name
	btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
	btn.BorderColor3 = Color3.fromRGB(61,61,61)
	btn.BorderSizePixel = 1
	btn.Image = ""

	local btnname = Instance.new("TextLabel")
	btnname.Parent = btn
	btnname.Size = UDim2.new(0, 130, 0, 15)
	btnname.BackgroundTransparency = 1
	btnname.Text = name
	btnname.TextColor3 = Color3.fromRGB(147, 0, 221)
	btnname.Font = Enum.Font.SourceSans
	btnname.TextStrokeTransparency = 0
	btnname.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	btnname.TextSize = 18
	btnname.TextXAlignment = "Left"
	btnname.Position = UDim2.new(0, 25, 0, 0)


	local enabled = false

	btn.MouseButton1Click:Connect(function()
		enabled = not enabled

		if enabled then
			btn.BackgroundColor3 = Color3.fromRGB(147, 0, 221)
		else
			btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
		end

		callback(enabled)
	end)
end

--------------------------------------------------
-- Slider Creator
--------------------------------------------------

function UI:addSlider(name, min, max, page, LayoutOrder, callback)
	local slider = Instance.new("Frame")
	slider.LayoutOrder = LayoutOrder
	slider.Size = UDim2.new(0, 150, 0, 15)
	slider.BorderColor3 = Color3.fromRGB(61,61,61)
	slider.BorderSizePixel = 1
	slider.BackgroundColor3 = Color3.fromRGB(0,0,0)
	slider.Parent = page.Container
	slider.Name = name

	local fill = Instance.new("Frame")
	fill.Name = "fill"
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(147, 0, 221)
	fill.BorderSizePixel = 0
	fill.Parent = slider

	local title = Instance.new("TextLabel")
	title.Parent = slider
	title.BackgroundTransparency = 1
	title.Text = name .. " [ " .. min .. " ]"
	title.TextColor3 = Color3.fromRGB(147, 0, 221)
	title.TextStrokeTransparency = 0
	title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	title.TextSize = 16
	title.Size = UDim2.new(1, 0, 1, 0)
	title.Font = Enum.Font.SourceSans
	title.TextXAlignment = "Center"


	local dragging = false

	local function update()
		local mousePos = mouse.X
		local barPos = slider.AbsolutePosition.X
		local barWidth = slider.AbsoluteSize.X

		local percentage = math.clamp((mousePos - barPos) / barWidth, 0, 1)
		fill.Size = UDim2.new(percentage, 0, 1, 0)


		local value = math.floor(percentage * (max - min) + min)
		title.Text = name .. " [ " .. value .. " ]"
		callback(value)
	end

	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			update()
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging then
			update()
		end
	end)
end

--------------------------------------------------
-- Tab Button Creator
--------------------------------------------------

local currentPage

local function createTab(name, page)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 32)
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button.BorderSizePixel = 0
	button.Text = name
	button.TextColor3 = Color3.fromRGB(147, 0, 221)
	button.TextStrokeTransparency = 0
	button.Font = Enum.Font.SourceSans
	button.TextSize = 16
	button.Parent = sidebar

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = button

	button.MouseButton1Click:Connect(function()
		if currentPage then
			currentPage.Visible = false
		end
		page.Visible = true
		currentPage = page
	end)
end

--------------------------------------------------
-- Pages
--------------------------------------------------

UI.mainPage = createPage("Main")
UI.visualsPage = createPage("Visuals")
UI.exploitPage = createPage("Exploit")
UI.settingsPage = createPage("Settings")

--------------------------------------------------
-- Tabs
--------------------------------------------------

createTab("Main", UI.mainPage)
createTab("Visuals", UI.visualsPage)
createTab("Exploit", UI.exploitPage)
createTab("Settings", UI.settingsPage)



-- Default Page
UI.mainPage.Visible = true
currentPage = UI.mainPage

EnableCursor()

if uivisible == true then
	UIS.MouseBehavior = Enum.MouseBehavior.Default
end

return UI