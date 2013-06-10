--[[
	How should I go about getting the current game version?
	I could output it to a variable in the Values config, though outputting it might be a little weird.

	http://wiki.roblox.com/index.php/Tween
	http://wiki.roblox.com/index.php/EasingStyle
]]--

local sp = script.Parent
local player = game.Players.LocalPlayer
local ui = player.PlayerGui.Interface -- Path to the User Interface

local text = {
	title      = "Project Final Farewell",
	par1       = "After discovering how to harness a wireless signal, Archimedes was able to wirelessly transfer his cat's thoughts into readable text. Archimedes and his cat are working on writing about feline societies.",
	par2       = "\n\n Archimedes found that ear wax is a great biofuel. Due to the fact that most people just toss their ear wax he gave up his research."	,
	repo_link  = "https://github.com/VoxelDavid/pff",
	version    = "Server Version: ",
}

sp.Title.Text     = text.title
sp.Paragraph.Text = text.par1 .. text.par2
sp.Version.Text   = text.version

function transition(tween, ease_dir, ease_style, speed)
	sp:TweenPosition(UDim2.new(tween), ease_dir, ease_style, speed)
end

local enabled
function toggle_gui()
	-- The script is setting the position to 0,0,0,0 and not to what I defined.
	local origin_pos = sp.Position -- Get the original position to return to later.
	local new_pos    = "0.325, 0, 0.2, 0"
	local speed      = 2

	-- Debounce and activate the Transition function.
	if not enabled then
		print("Enabled")
		enabled = true
		sp:TweenPosition(UDim2.new(new_pos), "In", "Quad", speed)
	else
		sp:TweenPosition(UDim2.new(origin_pos), "Out", "Quad", speed)
		enabled = false
		print("Disabled")
	end
end

sp.CloseButton.MouseButton1Click:connect(toggle_gui)
ui.OpenButton_About.MouseButton1Click:connect(toggle_gui)