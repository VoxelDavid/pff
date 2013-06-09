--[===================================[--
  Description:
    This file holds all of the configurable variables used throughout the game.

  Prerequisites:
    Include "repeat wait() until _G.config" in all functions.
    Some may not need it, but it's better to be safe than sorry.

  Keeping Organized:
    Order tables alphabetically.
    Keep variables of the same class (IE: Bool, Int, etc.) grouped together.
    Singular variables should be kept above Tables.
--]===================================]--

-- Game Version
_G.version   = "Beta 0.1.0"  -- The game Version. Be sure to keep this regularly updated!

-- Loose Variables
_G.values    = game.Workspace.GlobalScripts.Values -- Where all Values are stored.

-- Variables for all lighting related objects/scripts
_G.lighting = {
	brightness_when_day    = 0.3,  -- How bright a light should be in the day.
	brightness_when_night  = 1,    -- How bright a light should be at night.
	flicker_frequency      = 3,    -- How frequently a fire based light will flicker each second.

	candle = {
		range = 14,        -- Candle's PointLight range.
		light_speed = 6,   -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	},

	fireplace = {
		range = 18,        -- Fireplace's PointLight range.
		light_speed = 12,  -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	},

	torch = {
		range = 16,        -- Torch's PointLight range.
		light_speed = 8,   -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	},
}

-- Variables for the Day/Night time cycle.
_G.time_cycle = {
	enabled      = true,  -- If the Time Cycle should be enabled.
	sun_ambient  = true,  -- If the ambient should change for sunrise and sunset. (Not implemented)
	speed        = 1,     -- How fast the time will change.
	day_length   = 8,     -- How many minutes it will take to go from sunrise to sunset. (Not implemented)
	night_length = 4,     -- How many minutes it will take for night to pass. (Not implemented)
}

-- Special Users
_G.users = {
	-- Adminitrators
	admins = {
		"D3lego",
		"MonsterBone",
		"Player1",
	},

	-- Friends and other important people.
	vips = {
		"",
		"",
		"",
	}
}

_G.config = true
print("Loaded _G." .. script.Name)