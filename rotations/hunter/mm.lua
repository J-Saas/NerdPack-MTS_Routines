local mKey = 'MTSHunterMM'
local config = {
	key = mKey,
	profiles = true,
	title = '|T'..MTS.Interface.Logo..':10:10|t MTS Config',
	subtitle = 'Hunter Marksmanship Settings',
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
	-- Trueshot Use on every cooldown.
	{'Trueshot'}
}

local Pet = {
	-- Mend Pet
	{'Mend Pet', 'pet.health < 100'},
}

local AoE = {
	--Marked Shot whenever available.
	{'Marked Shot'},
	--Multi-Shot to dump Focus. Try to align with Bombardment procs.
	{'Multi-Shot', {'player.buff(Bombardment)', 'or', 'player.focus > 65'}}
}

local ST = {
	--Marked Shot to maintain Vulnerable.
	{'Marked Shot', {
		'!target.debuff(Vulnerable).count >= 3', 
		'or', -- OR
		'target.debuff(Vulnerable).duration < 8'
	}, 'target'},
	--Aimed Shot with Lock and Load or to dump excess Focus.
	{'Aimed Shot', {
		'player.buff(Lock and Load)',
		'or', -- OR
		'player.focus > 65'
	}, 'target'},
	--Arcane Shot to build Focus.
	{'Arcane Shot'}
}

local Keybinds = {
	-- Pause
	{'pause', 'modifier.alt'},
}

local outCombat = {
	{Keybinds},
}

NeP.Engine.registerRotation(254, '[|cff'..MTS.Interface.addonColor..'MTS|r] Hunter - Marksmanship', 
	{-- In-Combat
		{Keybinds},
		{Survival, 'player.health < 100'},
		{Cooldowns, 'modifier.cooldowns'},
		{pet, {'pet.exists', 'pet.alive'}},
		{AoE, 'player.area(8).enemies >= 3'},
		{ST}
	}, outCombat, exeOnLoad)