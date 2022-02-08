MAX_TARGET_DEBUFFS = 16;
MAX_TARGET_BUFFS = 32;

local targetDebuffList = {}
local currentTargetGUID = nil

function TargetBuffCooldownHook (self)
	local frameName;
	local frameCooldown;
	local selfName = self:GetName();

    for i = 1, MAX_TARGET_BUFFS do
        local buffName, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId, _, _, casterIsPlayer, nameplateShowAll = UnitBuff(self.unit, i, nil);
        if (buffName) then
            frameName = selfName.."Buff"..(i);
			if (duration) then
                -- Handle cooldowns
                frameCooldown = _G[frameName.."Cooldown"];
                CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                frameCooldown:ClearAllPoints();
                frameCooldown:Show();
			end
        else
            break;
        end
	end

	local index = 1;
	local maxDebuffs = self.maxDebuffs or MAX_TARGET_DEBUFFS;

	while ( index <= maxDebuffs ) do
	    local debuffName, icon, count, debuffType, _, _, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(self.unit, index, "INCLUDE_NAME_PLATE_ONLY");
		local duration, expirationTime = GetDebuffDuration(spellId)
		
		if currentTargetGUID == nil or currentTargetGUID ~= UnitGUID("target") then
			currentTargetGUID = UnitGUID("target")
			if currentTargetGUID then
				if targetDebuffList[currentTargetGUID] == nil then
					targetDebuffList[currentTargetGUID] = {}
				end
			else
				break;
			end
		end

		if ( debuffName ) then
			frameName = selfName.."Debuff"..index;

			if targetDebuffList[currentTargetGUID][index] == nil then
				targetDebuffList[currentTargetGUID][index] = {}
				targetDebuffList[currentTargetGUID][index].expirationTime = expirationTime
				targetDebuffList[currentTargetGUID][index].duration = duration
			end

			if targetDebuffList[currentTargetGUID][index].duration then
				if targetDebuffList[currentTargetGUID][index].expirationTime < GetTime() then
					table.remove(targetDebuffList[currentTargetGUID], index)
				end
				-- Handle cooldowns
				frameCooldown = _G[frameName.."Cooldown"];
				CooldownFrame_Set(frameCooldown, targetDebuffList[currentTargetGUID][index].expirationTime - targetDebuffList[currentTargetGUID][index].duration, 
					duration, duration > 0, true);
				frameCooldown:ClearAllPoints();
				frameCooldown:Show();
			end
		else
			break;
		end

		index = index + 1;
	end
end
			
hooksecurefunc("TargetFrame_UpdateAuras", TargetBuffCooldownHook)