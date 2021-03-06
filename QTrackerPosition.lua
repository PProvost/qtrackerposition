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

local orig_AchievementAlertFrame_FixAnchors
local function new_AchievementAlertFrame_FixAnchors(...)
	local fr1, fr2 = AchievementAlertFrame1, AchievementAlertFrame2
	if fr1 then
		fr1:ClearAllPoints()
		fr1:SetPoint("TOP", UIParent, "TOP", 0, -25)
	end

	if fr2 then
		fr2:ClearAllPoints()
		fr2:SetPoint("TOP", fr1 or UIParent, "BOTTOM", 0, -5)
	end
end

function f:PLAYER_LOGIN()
	-- Position the QuestWatchFrame
	QuestWatchFrame:ClearAllPoints();
	QuestWatchFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -195,-25)
	QuestWatchFrame.SetPoint = function() end
	QuestWatchFrame.ClearAllPoints = function() end

	-- Position the AchievementWatchFrame
	AchievementWatchFrame:ClearAllPoints();
	AchievementWatchFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 195,-25)
	AchievementWatchFrame:SetWidth(AchievementWatchFrame.desiredWidth or ACHIEVEMENTWATCH_MAXWIDTH);
	AchievementWatchFrame.SetPoint = function() end
	AchievementWatchFrame.ClearAllPoints = function() end
	AchievementWatchFrame.SetWidth = function() end

	-- Hook AchievementAlertFrame_FixAnchors to reposition it where we want
	old_AchievementAlertFrame_FixAnchors = AchievementAlertFrame_FixAnchors
	AchievementAlertFrame_FixAnchors = new_AchievementAlertFrame_FixAnchors
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end

