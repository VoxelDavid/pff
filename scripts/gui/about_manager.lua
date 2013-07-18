
local sp = script.Parent
local player = game.Players.LocalPlayer
local ui = player.PlayerGui.Interface -- Path to the User Interface

local text = {
	title      = "Project Final Farewell",
	par1       = "After discovering how to harness a wireless signal, Archimedes was able to wirelessly transfer his cat's thoughts into readable text. Archimedes and his cat are working on writing about feline societies.",
	par2       = "\n\n Archimedes found that ear wax is a great biofuel. Due to the fact that most people just toss their ear wax he gave up his research."	,
	version    = "Server Version: ",
}

sp.Title.Text     = text.title
sp.Paragraph.Text = text.par1 .. text.par2
sp.Version.Text   = text.version

local enabled
function toggle_gui()
	local speed = 1

	-- If it's not enabled, send it to the center of the screen, otherwise send it back up off screen.
	if not enabled then
		enabled = true
		sp:TweenPosition(UDim2.new(0.325,0, 0.2,0), "Out", "Elastic", speed, true)
	else
		sp:TweenPosition(UDim2.new(0.325,0, -0.5,0), "Out", "Quint", speed, true)
		enabled = false
	end
end

sp.CloseButton.MouseButton1Click:connect(toggle_gui)
ui.OpenButton_About.MouseButton1Click:connect(toggle_gui)