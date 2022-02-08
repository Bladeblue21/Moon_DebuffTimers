function GetDebuffDuration (spellID)
    if DebuffSpellList[spellID] then
        return DebuffSpellList[spellID].duration, (GetTime() + DebuffSpellList[spellID].duration)
    end
end

DebuffSpellList = {
	-- Priest
	-- Psychic scream
	[10890] = {
		name = "Psychic Scream",
		duration = 8,
	},
	-- Holy Fire
	[15261] = {
		name = "Holy Fire",
		duration = 10,
	},
	-- Shadow Word: Pain
	[10894] = {
		name = "Shadow Word: Pain",
		duration = 18,
	},
	-- Mind Soothe
	[10953] = {
		name = "Mind Soothe",
		duration = 15,
	},
	-- Weakened Soul
	[6788] = {
		name = "Weakened Soul",
		duration = 15,
	},

	-- Warlock
    [348] = {
		name = "Immolate",
		duration = 15,
	},
    [707] = {
		name = "Immolate",
		duration = 15,
	},
    [172] = {
		name = "Corruption",
		duration = 12,
	},
	[980] = {
		name = "Curse of Agony",
		duration = 24,
	},
}




