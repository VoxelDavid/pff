lighting = game:service("Lighting")
run = game:service("RunService")

while true do
	-- increment the time of day and then wait for a while
	lighting:SetMinutesAfterMidnight(lighting:GetMinutesAfterMidnight()+4)
	run.Stepped:wait()
end