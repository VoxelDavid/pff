--[===================================[--
  This scripts contains all variables used in the game as well
  as all of the Global Functions and script-configured values.

  Remember to include "repeat wait() until _G.config" in all functions!
  Some may not need it, but it's better to be safe than sorry.

  Keep orginized by:
  - Ordering tables alphabetically
  - Keeping variables of the same type (IE: Bool, Int, etc.) grouped together.
  - Putting singular variables above Tables.
--]===================================]--

-- Game Version
_G.version = "Alpha 0.1.0" -- The game Version. Be sure to keep this regularly updated!

-- Loose Variables
_G.conf = script.Configuration -- Where all values accessed by scripts are stored.

-- Variables for all lighting related objects/scripts
_G.lighting = {
	brightness_when_day    = 0.3,  -- How bright a light will be in the day.
	brightness_when_night  = 1,    -- How bright a light will be at night.
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
	sun_ambient  = true,  -- (Not implemented) If the ambient should change for sunrise and sunset.
	speed        = 1,     -- How fast the time will change.
	day_length   = 8,     -- (Not implemented) How many minutes it will take to go from sunrise to sunset.
	night_length = 4,     -- (Not implemented) How many minutes it will take for night to pass.
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

-- Let other scripts know that the variabes are ready for use.
_G.config = true

print("Loaded " .. script.Name)