--[==[--
  |--------------------------------------------------------------------------
  | Player Handler
  |--------------------------------------------------------------------------
  |
  |--------------------------------------------------------------------------
--]==]--

function player_joined(player)
	generate_user_objects(player)
end

function generate_user_objects(player)
	-- Configuration for user-specific Values.
	local config = Instance.new("Configuration", player)
end

game.Players.PlayerAdded:connect(player_joined)

-- PlayerAdded Solo fix -- remove for production.
for _, player in pairs(game.Players:GetPlayers()) do
	generate_user_objects(player)
end
print("[Warn]: Remove Solo fix from " ..script.Name.. " during production.")

print("Loaded "..script.Name)
