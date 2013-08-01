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

repeat wait() until _G.config

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

-- About Panel

local AboutPanel_enabled

function ShowAboutPanel()
	AboutPanel_enabled = false
	AboutPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
end

function HideAboutPanel()
	AboutPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	AboutPanel_enabled = true
end

function ToggleAboutPanel()
	if AboutPanel_enabled == true then
		AboutPanel_enabled = false
		ShowAboutPanel()
	else
		HideAboutPanel()
		AboutPanel_enabled = true
	end
end

-- Admin Panel

local AdminPanel_enabled

function ShowAdminPanel()
	AdminPanel_enabled = false
	AdminPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
end

function HideAdminPanel()
	AdminPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	AdminPanel_enabled = true
end

function ToggleAdminPanel()
	if AdminPanel_enabled == true then
		AdminPanel_enabled = false
		ShowAdminPanel()
	else
		HideAdminPanel()
		AdminPanel_enabled = true
	end
end

-- Cats Panel

local CatsPanel_enabled

function ShowCatsPanel()
	CatsPanel_enabled = false
	CatsPanel:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", 1, true)
end

function HideCatsPanel()
	CatsPanel:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", 0.5, true)
	CatsPanel_enabled = true
end

function ToggleCatsPanel()
	if CatsPanel_enabled == true then
		CatsPanel_enabled = false
		ShowCatsPanel()
	else
		HideCatsPanel()
		CatsPanel_enabled = true
	end
end

-- Hide Others

function HideOthers(excluded_frame)
	for _,v in pairs(sp:GetChildren()) do
		if v:IsA("Frame") and v.Name ~= excluded_frame then
			HideAboutPanel()
			HideAdminPanel()
			HideCatsPanel()
		end
	end
end

-- Function Calls

function OpenAbout()
	HideOthers()
	ToggleAboutPanel()
end

function HideAbout()
	ToggleAboutPanel()
end

function OpenAdmin()
	HideOthers()
	ToggleAdminPanel()
end

function HideAdmin()
	ToggleAdminPanel()
end

function OpenCats()
	HideOthers()
	ToggleCatsPanel()
end

function HideCats()
	ToggleCatsPanel()
end

sp.HideAll.MouseButton1Down:connect(function()
	HideOthers()
end)


sp.OpenAbout.MouseButton1Down:connect(OpenAbout)
sp.About.CloseButton.MouseButton1Down:connect(HideAbout)

sp.OpenAdmin.MouseButton1Down:connect(OpenAdmin)
sp.Admin.CloseButton.MouseButton1Down:connect(HideAdmin)

sp.OpenCats.MouseButton1Down:connect(OpenCats)
CatsPanel.CloseButton.MouseButton1Down:connect(HideCats)

print("Loaded "..script.Name)
