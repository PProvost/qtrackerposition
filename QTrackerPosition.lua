--[[
QTrackerPosition/QTrackerPosition.lua

Copyright 2008 Quaiche

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
]]

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

function f:PLAYER_LOGIN()
	QuestWatchFrame:ClearAllPoints();
	QuestWatchFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -195,-25)
	QuestWatchFrame.SetPoint = function() end
	QuestWatchFrame.ClearAllPoints = function() end

	AchievementWatchFrame:ClearAllPoints();
	AchievementWatchFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 195,-25)
	AchievementWatchFrame:SetWidth(AchievementWatchFrame.desiredWidth or ACHIEVEMENTWATCH_MAXWIDTH);
	AchievementWatchFrame.SetPoint = function() end
	AchievementWatchFrame.ClearAllPoints = function() end
	AchievementWatchFrame.SetWidth = function() end
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end

