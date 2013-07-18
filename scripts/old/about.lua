local RbxGui = assert(LoadLibrary("RbxGui")) -- Load the Library

local sp = script.Parent

local text = {
	header     = "Project Final Farewell",
	paragraph1 = "After discovering how to harness a wireless signal, Archimedes was able to wirelessly transfer his cat's thoughts into readable text. Archimedes and his cat are working on writing about feline societies.",
	paragraph2 = "Archimedes found that ear wax is a great biofuel. Due to the fact that most people just toss their ear wax he gave up his research.",
	repo_link  = "https://github.com/VoxelDavid/pff",
}

function dismiss()
	-- Transition the Gui away. Does RbxGui have any transitions?
end

function never_show_again()
	-- Use Data Persistence to never show the About window again to that user.
	-- I think an options panel would be nice so if you want it back again you can reenable it.
end

function generate_gui(player)
	-- Instance Creation
	local screen     = Instance.new("ScreenGui")
	local frame      = Instance.new("Frame")
	local header     = Instance.new("TextLabel")
	local par1       = Instance.new("TextLabel")
	local par2       = Instance.new("TextLabel")
	local repo_link  = Instance.new("TextLabel")
	local dismiss    = Instance.new("ImageButton")
	local never_show = Instance.new("ImageButton")

	-- ScreenGui
	screen.Name   = "Generated Gui" -- Rename to "About"
	screen.Parent = player.PlayerGui

	-- Frame
	frame.Parent   = screen
	frame.Position = UDim2.new(0.25,0, 0.25,0)
	frame.Size     = UDim2.new(0.5,0, 0.5,0)
	frame.Style    = "RobloxRound"

	-- Header
	header.Name     = "Header"
	header.Parent   = frame
	header.Position = UDim2.new(0,0, 0,0)
	header.Size     = UDim2.new(1,0, 0.1,0)
	header.FontSize = "Size14"
	header.TextColor3 = Color3.new(235, 235, 235)

	-- First Paragraph
	par1.Name       = "Paragraph1"
	par1.Parent     = frame
	par1.Position   = UDim2.new(0,0, 0.2,0)
	par1.Size       = UDim2.new(1,0, 0.25,0)
	par1.FontSize   = "Size10"
	par1.Text       = text.par1
	par1.TextColor3 = Color3.new(235, 235, 235)

	-- Second Paragraph
	par2.Name       = "Paragraph2"
	par2.Parent     = frame
	par2.Position   = UDim2.new(0,0, 0.5,0)
	par2.Size       = UDim2.new(1,0, 0.25,0)
	par2.FontSize   = "Size10"
	par2.Text       = text.par2
	par2.TextColor3 = Color3.new(235, 235, 235)

	-- Repository Link
	repo_link.Name       = "RepoLink"
	repo_link.Parent     = frame
	repo_link.Position   = UDim2.new(0,0, 0.9,0)
	repo_link.Size       = UDim2.new(1,0, 0.05,0)
	repo_link.FontSize   = "Size10"
	repo_link.Text       = text.repo_link
	repo_link.TextColor3 = Color3.new(235, 235, 235)

	-- Dismiss Button
	dismiss.Name     = "Dismiss"
	dismiss.Parent   = frame
	dismiss.BackgroundTransparency = 1
	dismiss.Position = UDim2.new()
	dismiss.Size     = UDim2.new()

	-- Never Show Again Button
	never_show.Name     = "NeverShow"
	never_show.Parent   = frame
	never_show.BackgroundTransparency = 1
	never_show.Position = UDim2.new()
	never_show.Size     = UDim2.new()
end
game.Players.PlayerAdded:connect(generate_gui)