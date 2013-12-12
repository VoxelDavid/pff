
--[[
 ## GLOBAL

 This script contains all of the variables accessed throughout the game. All
 children of this script are Global Functions accessed by "call scripts".

 View the documentation for more info.
]]--

-- ##
-- ## Variables
-- ##

_G.version = "Alpha 0.1.0";        -- Game Version — Keep this regularly updated!
_G.config = script.Configuration;  -- Where all values accessed by Scripts are stored.


-- ##
-- ## Tables
-- ##

-- Variables for all lighting related objects/scripts
_G.lighting = {
	brightness_when_day   = 0.3,  -- How bright a light will be in the day.
	brightness_when_night = 1,    -- How bright a light will be at night.
	flicker_frequency     = 3,    -- How frequently a fire based light will flicker each second.

	candle = {
		range       = 14,  -- Candle's PointLight range.
		light_speed = 6,   -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	};

	fireplace = {
		range       = 18,  -- Fireplace's PointLight range.
		light_speed = 12,  -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	};

	torch = {
		range       = 16,  -- Torch's PointLight range.
		light_speed = 8,   -- How quickly the fire will be lit. Bigger number = slower transition.
		ext_speed   = 3,   -- How quickly the fire will be extinguished. Bigger number = slower transition.
	};
};

-- Special Users
_G.users = {
	-- Administrators
	admins = {
		"D3lego",
		"MonsterBone",
		"Player1",
	};

	-- Friends and other important people.
	vips = {
		"",
		"",
		"",
	};
};

-- Let other scripts know that the variables are ready for use.
_G.ready = true;

-- The script is loaded!
print("Loaded "..script.Name);
