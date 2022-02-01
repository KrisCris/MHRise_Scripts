local hwKB = nil
local questManager = nil
local enemyManager = nil
local skip = false
local counter = 0;


re.on_pre_application_entry("UpdateBehavior", function()
    counter = counter + 1
    if not questManager then
        questManager = sdk.get_managed_singleton("snow.QuestManager")
        if not questManager then
            return nil
        end
    end

    if not hwKB then
        hwKB = sdk.get_managed_singleton("snow.GameKeyboard"):get_field("hardKeyboard")
    end

    if not enemyManager then
        enemyManager = sdk.get_managed_singleton("snow.enemy.EnemyManager")
        if not enemyManager then
            return nil
        end
    end

    -- 0: still in quest, 1: ending countdown, 8: ending animation, 16: quest over
    local endFlow = questManager:get_field("_EndFlow")

    if (hwKB:call("getTrg", 35)) then
        skip = not skip
        log.info("[OneKeyQuestClear] Enabled: " .. tostring(skip))
    end

    if endFlow == 0 and skip then
        -- 1: hunting, 2: kill, 4: capture, 16: collect
        local questType = questManager:get_field("_QuestType")

        if questManager:call("isHyakuryuQuest") then
            -- we need a better way to clear rampage quests
            -- questManager:call("setQuestClear")
            KillEnemy("Boss")

        elseif questManager:call("isItemTargetQuest") or questType == 4 then
            questManager:call("setQuestClear")
        else
            if questManager:call("isZakoTargetQuest") then
                KillEnemy("Zako")
            end
            KillEnemy("Boss")
        end
    end

    local timer = questManager:get_field("_QuestEndFlowTimer")
    if (endFlow == 1 or endFlow == 8) and skip and timer > 1.0 and not questManager:call("isHyakuryuQuest") then
        questManager:set_field("_QuestEndFlowTimer", 1.0)
        skip = not skip
    end

end)

function KillEnemy(type)
    if counter % 300 == 0 then
        local enemyCount = enemyManager:call("get" .. type .. "EnemyCount")
        if enemyCount == nil or enemyCount == 0 then
            log.info("[OneKeyQuestClear] Enemy not exist")
            return nil
        end

        for i = 0, enemyCount - 1 do
            repeat
                local enemy = enemyManager:call("get" .. type .. "Enemy", i);
                if enemy == nil then
                    log.info("[OneKeyQuestClear] Enemy "..i.." not exist")
                    break
                end

                if enemy:call("isEnableDie", 0) and not enemy:call("checkDie") then
                    enemy:call("dieSelf")
                end
            until true
        end
    end
end
