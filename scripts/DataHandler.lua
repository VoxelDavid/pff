--[==[--
  |--------------------------------------------------------------------------
  | Data Handler
  |--------------------------------------------------------------------------
  |
  | Saves and loads all player data.
  |
  |--------------------------------------------------------------------------
--]==]--

_G.user_data = {
	first_visit = true,
	show_about_on_join = true,

	number = 2,
	text = "Type something!",
}

local RbxUtl = LoadLibrary("RbxUtility")

function load_data(player)
	player:WaitForDataReady()
	player:LoadString("user_data", RbxUtl.DecodeJSON(_G.user_data))
end

function save_data(player)
	player:WaitForDataReady()
	player:SaveString("user_data", RbxUtl.EncodeJSON(_G.user_data))
end

game.Players.PlayerAdded:connect(load_data)
game.Players.PlayerRemoving:connect(save_data)

print("Loaded "..script.Name)
