local mKey = 'MTSDKFrost'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Death Knight Frost Settings',
	color = NeP.Core.classColor('player'),
	width = 250,
	height = 500,
	config = {
		
	}
}

NeP.Interface.buildGUI(config)
local E = MTS.dynEval
local F = function(key) return NeP.Interface.fetchKey(mKey, key, 100) end

local exeOnLoad = function()
	MTS.Splash()
	MTS.ClassSetting(mKey)
end

local Survival = {

}

local Cooldowns = {

}

local AoE = {

}

local ST = {
	--Frost Fever maintain at all times via Howling Blast.
	{'Howling Blast', '!target.debuff(Frost Fever)'},
	--Obliterate with Killing Machine procs.
	{'Obliterate', 'player.buff(Killing Machine)'},
	--Howling Blast with Rime procs.
	{'Howling Blast', 'player.buff(Rime)'},
	--Obliterate to dump Runes.
	{'Obliterate', 'player.runes >= 4'},
	--Frost Strike to dump Runic Power.
	{'Frost Strike'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(251, '[|cff'..MTS.Interface.addonColor..'MTS|r] Death Knight - Frost', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{AoE, 'player.area(8).enemies >= 3'},
		{ST}
	}, outCombat, exeOnLoad)