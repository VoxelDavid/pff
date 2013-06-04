--[===================================[--
	@Description:
		This file holds all of the configurable variables used throughout the game.

	@Prerequisites:
		Include "repeat wait() until _G.variables" in all functions.
		Some may not need it, but it's better to be safe than sorry.

	@Keeping Organized:
		Order tables alphabetically.
		Keep variables of the same type grouped together.
		Singular variables should be kept above Tables.
--]===================================]--

_G.wait_time            = 0.06  -- Default wait() is about 0.03-0.04. Using a slightly higher wait time should increase performance, if just a tiny bit.

-- Variables for all lighting related objects/scripts
_G.lighting = {
	brightness_when_day   = 0.2,   -- How bright a light should be in the day.
	brightness_when_night = 1,     -- How bright a light should be at night.
	flicker_frequency     = 3,     -- How frequently a fire based light will flicker each second.
	ranges = {
		candle              = 15,    -- Light source range of a Candle.
		fireplace           = 17,    -- Light source range of a Fireplace.
	}
}

-- Variables for the Day/Night time cycle.
_G.time_cycle = {
	enabled               = true,  -- If the Time Cycle should be enabled.
	sun_ambient           = true,  -- If the ambient should change for sunrise and sunset.
	speed                 = 1,     -- How fast the time will change.
	day_length            = 8,     -- How many minutes it will take to go from sunrise to sunset.
	night_length          = 4,     -- How many minutes it will take for night to pass.
}

-- Important users with access to exclucive utilities.
_G.superusers = {
	"D3lego",
	"MonsterBone",
	"Player1",
}


_G.variables = true
print("_G.variables Loaded")