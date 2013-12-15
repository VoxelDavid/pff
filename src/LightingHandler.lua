
--[[
 Lighting Handler
 ================

 This script takes care of lighting related tasks, such as the Day/Night cycle,
 setting a 'time of day' value for other scripts to hook into, so they can adjust
 things depending on the time, and changing the ambiance at sunrise and sunset.
]]--

repeat wait() until _G.ready

-- Script Configuration
local config = {
    lighting_ambiance = true,  -- (Not implemented) If the ambiance should change for sunrise and sunset.
    time_increment    = 1,     -- The amount added to the current time every loop.
    loop_speed        = 0.5,   -- How quickly the loop will iterate.
    day_length        = 480,   -- (Not implemented) How many seconds it will take to go from sunrise to sunset.
    night_length      = 240,   -- (Not implemented) How many seconds it will take for night to pass.
}

local l = game:service("Lighting")


--[[
 Starts the main loop
]]--
function LightingHandler()
    while wait(config.loop_speed) do
        TimeCycle()
        OutputTimeOfDay()
    end
end


--[[
 Increments the current time by config.time_increment
]]--
function TimeCycle()
    l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + config.time_increment)
end


--[[
 Sets the _G.config.time_of_day value to a number between 1 and 4.
 1 is Sunrise, 2 is Day, 3 is Sunset and 4 is Night.

 Other scripts can then check this value and adjust based on the time.
]]--
function OutputTimeOfDay()
    local time_of_day = _G.config.time_of_day

    local sunrise_start = 360
    local sunrise_end   = sunrise_start + 60
    local sunset_start  = 1060
    local sunset_end    = sunset_start + 60

    -- Check the time against the 4 grouped variables above
    -- and output the time of day accordingly.

    -- Between sunrise_start and sunrise_end
    if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
        time_of_day.Value = 1 -- Sunrise

    -- Between sunrise_end and sunset_start
    elseif l:GetMinutesAfterMidnight() > sunrise_end and l:GetMinutesAfterMidnight() < sunset_start then
        time_of_day.Value = 2 -- Day

    -- Between sunset_start and sunset_end
    elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
        time_of_day.Value = 3 -- Sunset

    -- Between sunset_end and sunrise_start
    elseif l:GetMinutesAfterMidnight() > sunset_end and l:GetMinutesAfterMidnight() < sunrise_start then
        -- For some reason time_of_day is never getting set to 4.
        -- I'm not sure why that would be, the condition looks like it would work fine.
        time_of_day.Value = 4 -- Night

    end
end


--[[
 Coming later. This will change the Sky's ambiance at
 Sunrise and Sunset.
]]--
function ChangeAmbiance()
    if config.lighting_ambiance == false then
        return
    end

    -- code
end


-- The script is loaded!
print("Loaded " .. script.Name)

-- Run the function to get the loop started.
LightingHandler()
