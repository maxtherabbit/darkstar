---------------------------------------------------
-- Mind Drain
-- Steals mnd from target
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
    local typeEffect = EFFECT_MND_DOWN;

    if(target:hasStatusEffect(typeEffect) == false) then
        local statmod = MOD_INT;
        local resist = applyPlayerResistance(mob,typeEffect,target,mob:getStat(statmod)-target:getStat(statmod),0,ELE_WATER);
        if(resist > 0.2) then
            skill:setMsg(334);
            target:addStatusEffect(typeEffect,10,0,120*resist);
            mob:addStatusEffect(EFFECT_MND_BOOST, 10, 0, 120);
        else
            skill:setMsg(MSG_MISS); -- resist !
        end
    else
        skill:setMsg(MSG_NO_EFFECT);
    end
    return typeEffect;
end;