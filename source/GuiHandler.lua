--[==[--
  |--------------------------------------------------------------------------
  | Gui Handler
  |--------------------------------------------------------------------------
  |
  | Takes care of everything Gui related in the Interface ScreenGui.
  |
  | @ToDo:
  | - Save the "Interface" ScreenGui as a Model.
  |
  | - Toggles do not work for closing because of HideAll not being able to to
  |   know not to hide certain panels.
  |
  | - Think up a more compact way to do everything. This seems a bit absurd.
  |   I could probably just compact the toggles/hides/shows into 3 functions
  |   and pass parameters to get the proper outcome.
  |
  |--------------------------------------------------------------------------
--]==]--

repeat wait() until _G.ready

local sp = script.Parent

local AdminPanel = sp.Admin
local AboutPanel = sp.About
local CatsPanel = sp.Cats

-- Settings

local about_text = {
	title      = "Project Final Farewell";
	par1       = "After discovering how to harness a wireless signal, Archimedes was able to wirelessly transfer his cat's thoughts into readable text. Archimedes and his cat are working on writing about feline societies.";
	par2       = "\n\n Archimedes found that ear wax is a great biofuel. Due to the fact that most people just toss their ear wax he gave up his research."	;
	version    = "Server Version: " .. _G.version;
}

AboutPanel.Title.Text     = about_text.title
AboutPanel.Paragraph.Text = about_text.par1 .. about_text.par2
AboutPanel.Version.Text   = about_text.version


function ShowFrame(frame)
	--[[
	  Tweens the Frame specified in the function call onto the screen

	  @param (string) frame : The name of the Frame object to Tween
	  Example use: ShowFrame("About")
	--]]

	local frame = string.lower(frame)

	if frame == "about" then
		AboutPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
	elseif frame == "admin" then
		AdminPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
	elseif frame == "cats" then
		CatsPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
	end
end

function HideFrame(frame)
	--[[
	  Tweens the Frame specified in the function call off-screen.

	  @param (string) frame : The name of the Frame object to Tween
	  Example use: HideFrame("About")
	--]]

	local frame = string.lower(frame)

	if frame == "about" then
		AboutPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	elseif frame == "admin" then
		AdminPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	elseif frame == "cats" then
		CatsPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	end
end

function ToggleFrame(frame)
	--[[
	  Toggles between ShowFrame and HideFrame functions.

	  @param (string) frame : The name of the Frame object to Tween
	  Example use: ToggleFrame("About")
	--]]

	local frame = string.lower(frame)
	local enabled = true

	-- I think I'll need to use Bool values in the ScrenGuis
	-- so I can enable/disable them easily... Or I could define
	-- values in this script.

	-- Using bool values in the Frames is probably the best option.
	-- I can check that frames value. Not sure if I could do that with variables.

	if enabled == true then
		enabled = false
		ShowFrame(frame)
	else
		HideFrame(frame)
		enabled = true
	end
end

--[[
  Tweens all frames off-screen, leaving only the one specified as the parameter visible.

  @param (string) excluded_frame : Frame object to exclude from hiding.
  Example use: HideOthers("About")
--]]
function HideOthers(excluded_frame)
	for _,v in pairs(sp:GetChildren()) do
		if v:IsA("Frame") then
			local frame = excluded_frame
			-- Damn you, logic! How do I make this work?
			HideAboutPanel(frame)
			HideAdminPanel(frame)
			HideCatsPanel(frame)
		end
	end
end

-- Function Calls

-- This is a mess. I need to improve these function calls later.

sp.OpenAbout.MouseButton1Down:connect(function()
	ToggleFrame("About")
end)
sp.OpenAbout.MouseButton1Down:connect(function()
	HideOthers("About")
	ToggleFrame("About")
end)

sp.OpenAbout.MouseButton1Down:connect(function()
	ToggleFrame("Admin")
end)
sp.OpenAbout.MouseButton1Down:connect(function()
	HideOthers("Admin")
	ToggleFrame("Admin")
end)

sp.OpenAbout.MouseButton1Down:connect(function()
	ToggleFrame("Cats")
end)
sp.OpenAbout.MouseButton1Down:connect(function()
	HideOthers("Cats")
	ToggleFrame("Cats")
end)

sp.HideAll.MouseButton1Down:connect(function()
	HideOthers()
end)

print("Loaded "..script.Name)
