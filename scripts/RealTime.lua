-- Ganondude

local time_zone = -5 -- Time zone, offset from GMT.

local tz_diff = 5*3600 + time_zone*3600
local secondsInDay = 60*60*24

while true do
	game.Lighting:setMinutesAfterMidnight(math.fmod(tick() + tz_diff,secondsInDay)/60)
	wait(0.1)
end