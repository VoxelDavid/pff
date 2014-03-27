
--[[
 Player Handler
 ==============

 This script takes care of Player related tasks, such as Data Persistence,
 Leaderboards, and generating player-specific configuration objects/values.
]]--


--[[
 Runs on PlayerAdded connection, generates Configuration object and loads
 the Player's data, if any.

 @param player (string) The Player.
]]--
function PlayerJoined(player)
	GeneratePlayerObjects(player)
	LoadData(player)
end

--[[
 Runs on PlayerRemoving connection; saves the Player's data.

 @param player (string) The Player.
]]--
function PlayerLeft(player)
	SaveData(player)
end


--[[
 Creates new instances of objects for the newly joined Player.

 @param player (string) The Player.
]]--
function GeneratePlayerObjects(player)
	-- Configuration for user-specific Values.
	local config = Instance.new("Configuration", player)
end


-- ##
-- ## Data Persistence
-- ##

_G.user_data = {
	first_visit = true,
	show_about_on_join = true,

	number = 2,
	text = "Type something!",
}

local RbxUtl = LoadLibrary("RbxUtility")

--[[
 Saves the Player's data.

 @param player (string) The Player.
]]
function SaveData(player)
	player:WaitForDataReady()
	player:SaveString("user_data", RbxUtl.EncodeJSON(_G.user_data))
end

--[[
 Loads the Player's data.

 @param player (string) The Player.
]]
function LoadData(player)
	player:WaitForDataReady()

	-- I'm decoding the already existing user_data table?
	player:LoadString("user_data", RbxUtl.DecodeJSON(_G.user_data))
end


-- Connection lines
game.Players.PlayerAdded:connect(PlayerJoined)
game.Players.PlayerRemoving:connect(PlayerLeft)


-- PlayerAdded Solo fix -- remove for production.
for _, player in pairs(game.Players:GetPlayers()) do
	GeneratePlayerObjects(player)
end
print("[Warn]: Remove Solo fix from " ..script.Name.. " during production.")
-- end solo fix


-- The script is loaded!
print("Loaded "..script.Name)
