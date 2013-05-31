--[[
	Author: crazyman32
]]

local StartTime = 12

local showTime = true

function startDayLoop()
	local l = game.Lighting
	l.TimeOfDay = StartTime
	local t = StartTime
	local m = nil
	local am = " AM"
	local pm = " PM"
	if (showTime) then
		local M = Instance.new("Hint")
		M.Name = "Time"
		M.Text = "Time - " .. string.sub(l.TimeOfDay,1,2) .. string.sub(l.TimeOfDay,3,5)
		M.Parent = game.Workspace
		m = M
	end
	while true do
		l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() +0.06)
		if (showTime) then
			if (tonumber(string.sub(l.TimeOfDay,1,2))/12 >= 1) then
				if (tonumber(string.sub(l.TimeOfDay,1,2))/12 == 1) then
					m.Text = "Time - 12" .. string.sub(l.TimeOfDay,3,5) .. pm
				else
					m.Text = "Time - " .. tostring(tonumber(string.sub(l.TimeOfDay,1,2))-12) .. string.sub(l.TimeOfDay,3,5) .. pm
				end
			else
				if (tonumber(string.sub(l.TimeOfDay,1,2)) == 0) then
					m.Text = "Time - 12" .. string.sub(l.TimeOfDay,3,5) .. am
				else
					m.Text = "Time - " .. string.sub(l.TimeOfDay,1,2) .. string.sub(l.TimeOfDay,3,5) .. am
				end
			end
		end
		wait(0.06)
	end
end

startDayLoop()