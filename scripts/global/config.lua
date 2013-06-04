--[===================================[--
	This file holds all of the configurable variables used throughout the game.

	Be sure to describe the comment and variable well!
--]===================================]--


-- Important users with access to exclucive utilities.
_G.superusers = {
	"D3lego",
	"MonsterBone",
	"Player1",
}
-- I need to learn to implement tables so I can use something nice and organized like this.
-- _G.time_cycle = {
-- 	enabled      = true,
-- 	speed        = 1,
-- 	day_length   = 8,
-- 	night_length = 4,
-- 	sun_ambient  = true,
-- }

_G.base_wait_time                  = 0.06  -- Default wait() is about 0.03-0.04. Using a slightly higher wait time should increase performance, if just a tiny bit.

-- Is it even nessecary to make these global?
_G.time_cycle_enabled              = true  -- If the Time Cycle should be enabled.
_G.time_cycle_speed                = 1     -- How fast the time will change.
_G.time_cycle_day_length           = 8     -- How many minutes it will take to go from sunrise to sunset.
_G.time_cycle_night_length         = 4     -- How many minutes it will take for night to pass.
_G.time_cycle_sun_ambient          = true  -- If the ambient should change for sunrise and sunset.

_G.light_brightness_when_day       = 0.1   -- How bright a light should be in the day.
_G.light_brightness_when_night     = 1     -- How bright a light should be at night.

_G.light_flicker_frequency         = 3     -- How frequently a fire based light will flicker each second.

_G.light_candle_range              = 15    -- Light source range of a Candle.
_G.light_fireplace_range           = 17    -- Light source range of a Fireplace.


_G.variables = true
print("_G.variables Loaded")