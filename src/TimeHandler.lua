
--[[
 ## Time Handler

 This function loops through the Day/Night and will output if it's Sunrise,
 Day, Sunset or Night to the _G.config.time_of_day value so other scripts
 can hook into it and adjust based on the time.


 ## Associated Variables and Values:

 _G.time_cycle
   enabled        (bool) Controls whether the while loop will run or not.
   time_increment (int)  The amount added to the current time every loop.
   loop_speed     (int)  How quickly the loop will iterate.

 _G.config
   time_of_day    (int)  Set by OutputTimeOfDay()
]]--

repeat wait() until _G.ready

l = game:service("Lighting")

-- Main function
function TimeHandler()
    if _G.time_cycle.enabled == false then
        return
    end

    while wait(_G.time_cycle.loop_speed) do
        TimeCycle()
        OutputTimeOfDay()
    end -- end while
end -- end function


function TimeCycle()
    -- Adds time_increment to the current time each loop.
    l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + _G.time_cycle.time_increment)
end


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
        time_of_day.Value = 4 -- Night

    end -- end if
end -- end function


function ChangeAmbiance()
    -- Coming later. This will change the lighting Ambiance
    -- depending on the value of time_of_day
    if _G.time_cycle.sky_ambiance == false then
        return
    end

end -- end function


print("Loaded " .. script.Name)

-- Run the function to get the loop started.
TimeHandler()
