local questManager = nil
local enemyManager = nil
local hwKB = nil
local killAll = false
local ignoreQuestState = true
local clearQuest = false
local perserveTarget = false
local kbControlAutoDisable = true

local timer = 0.0
local kbInput = false

local app_type = sdk.find_type_definition("via.Application")
local get_elapsed_second = app_type:get_method("get_UpTimeSecond")

local function get_time()
    return get_elapsed_second:call(nil)
end

re.on_pre_application_entry("UpdateBehavior", function() 
    if not hwKB then
        hwKB = sdk.get_managed_singleton("snow.GameKeyboard"):get_field("hardKeyboard") -- getting hardware keyboard manager
    end

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

    local endFlow = questManager:get_field("_EndFlow")
    local questStatus = questManager:get_field("_QuestStatus")

    if endFlow == 0 and questStatus == 2 and clearQuest then
        questManager:call("setQuestClear")
        clearQuest = false
    end
    
end)


re.on_frame(function()

    if (hwKB:call("getTrg", 46)) then
        killAll = not killAll
        if killAll and kbControlAutoDisable then
            timer = get_time()
            kbInput = true
        end
    end

    if killAll and kbControlAutoDisable and kbInput then
        local now = get_time()
        local delta = now - timer

        if delta > 1.0 then
            killAll = not killAll
            timer = 0.0
            kbInput = false
        end
    end

end)


re.on_draw_ui(function()
    imgui.text("OneKeyQuestClear - Press DEL Key")
    changed, killAll = imgui.checkbox("KillAll", killAll)
    if imgui.button("ClearQuest") then
        clearQuest = true
    end
    changed, perserveTarget = imgui.checkbox("PerserveTarget", perserveTarget)
    changed, ignoreQuestState = imgui.checkbox("IgnoreQuestState", ignoreQuestState)
    changed, kbControlAutoDisable = imgui.checkbox("KbControlAutoUnselect", kbControlAutoDisable)

    -- if changed then
    --     enable = true
    --     timer = get_time()
    -- end
end)


local function pre_enemy_update(args)
    local endFlow = questManager:get_field("_EndFlow")
    local questType = questManager:get_field("_QuestType")
    local questStatus = questManager:get_field("_QuestStatus")

    if killAll and (endFlow == 0 or ignoreQuestState) and questType ~= 4 then
        local enemy = sdk.to_managed_object(args[2])
        if perserveTarget and enemy then
            if questManager:call("isQuestTargetEnemy", enemy:get_field("<EnemyType>k__BackingField") ,true) then
                return
            end
        end
        enemy:call("dieSelf")
    end
end

local function post_enemy_update(retval)
    return retval
end

sdk.hook(
    sdk.find_type_definition("snow.enemy.EnemyCharacterBase"):get_method("update"),
    pre_enemy_update,
    post_enemy_update
)