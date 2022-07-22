-- author: github.com/krisCris
-- fonts
local FONT_NAME = "NotoSansSC-Regular.otf"
local FONT_SIZE = 18

local CHINESE_GLYPH_RANGES = {
    0x0020, 0x00FF, -- Basic Latin + Latin Supplement
    0x2000, 0x206F, -- General Punctuation
    0x3000, 0x30FF, -- CJK Symbols and Punctuations, Hiragana, Katakana
    0x31F0, 0x31FF, -- Katakana Phonetic Extensions
    0xFF00, 0xFFEF, -- Half-width characters
    0x4e00, 0x9FAF, -- CJK Ideograms
    0,
}

local font = imgui.load_font(FONT_NAME, FONT_SIZE, CHINESE_GLYPH_RANGES)

-- singletons
local questManager = nil
local hwKB = nil
local chatManager = nil
local messageManager = nil


-- flags
local clearQuest = false
local enableKill = false
local enablePartsBreak = false

local killIds = {}

local settings = {
    disableOnModeSwitch = true,
    disableOnQuestClear = true,
    breakPartsOnKill = false,
    separateWindow = false,
    modeId = 0
}

local modes = {
    "Zako Only",
    "Perserve Quest Target(s)",
    "Camera Selected Target",
    "Quest Target(s) Only",
    "Target All"
}

-- serialization
local function save_settings()
    json.dump_file("QuestClear.json", settings)
end

local function load_settings()
    local loadedTable = json.load_file("QuestClear.json")
    if loadedTable ~= nil then
        settings = loadedTable
    end
end

local function clearTable()
    killIds = {}
end

local function disableAll()
    enableKill = false
    enablePartsBreak = false
end

local appType = sdk.find_type_definition("via.Application")
local getElapsedSecond = appType:get_method("get_UpTimeSecond")
local function getTime()
    return getElapsedSecond:call(nil)
end

local function drawUI()
    changed, settings.modeId = imgui.combo("Mode (PageUP)", settings.modeId, modes);
    if changed then
        save_settings()
    end

    changed, enableKill = imgui.checkbox("Kill (DEL)", enableKill)
    changed, enablePartsBreak = imgui.checkbox("PartsBreak (END)", enablePartsBreak)

    if imgui.button("ClearQuest") then
        clearQuest = true
    end

    if imgui.checkbox("DisableOnQuestClear", settings.disableOnQuestClear) then
        settings.disableOnQuestClear = not settings.disableOnQuestClear
        save_settings()
    end

    if imgui.checkbox("DisableOnSwitchingMode", settings.disableOnModeSwitch) then
        settings.disableOnModeSwitch = not settings.disableOnModeSwitch
        save_settings()
    end

    if imgui.checkbox("AutoBreakPartsOnKill", settings.breakPartsOnKill) then
        settings.breakPartsOnKill = not settings.breakPartsOnKill
        save_settings()
    end

    if imgui.checkbox("ShowSeperateWindow", settings.separateWindow) then
        settings.separateWindow = not settings.separateWindow
        save_settings()
    end

    -- if imgui.tree_node("DEBUG") then
    --     if imgui.tree_node("KillList") then
    --         for _, value in pairs(killIds) do
    --             imgui.text(tostring(value.name) .. "Atmps: " .. tostring(value.attempts).."; Min: "..tostring(value.min))
    --         end
    --         imgui.tree_pop();
    --     end
    --     imgui.tree_pop();
    -- end
end


load_settings()


re.on_pre_application_entry("UpdateBehavior", function()
    if not questManager then
        questManager = sdk.get_managed_singleton("snow.QuestManager")
        if not questManager then
            return nil
        end
    end

    -- getting Quest End state
    -- 0: still in quest, 1: ending countdown, 8: ending animation, 16: quest over
    local endFlow = questManager:get_field("_EndFlow")
    if endFlow >= 0 and endFlow < 16 then
    else
        clearTable()
        if settings.disableOnQuestClear then
            disableAll()
        end
    end

    local questStatus = questManager:get_field("_QuestStatus")

    if endFlow == 0 and questStatus == 2 and clearQuest then
        questManager:call("setQuestClear")
        clearQuest = false
    end
end)


re.on_frame(function()
    imgui.push_font(font)
    
    if not hwKB then
        hwKB = sdk.get_managed_singleton("snow.GameKeyboard"):get_field("hardKeyboard") -- getting hardware keyboard manager
        if not hwKB then
            return
        end
    end

    if not chatManager then
        chatManager = sdk.get_managed_singleton("snow.gui.ChatManager")
        if not chatManager then
            return
        end
    end

    -- DEL
    if hwKB ~= nil and hwKB:call("getTrg", 46) then
        enableKill = not enableKill
        chatManager:call(
            "reqAddChatInfomation",
            "<COLOR 05FFA1>ONE KEY QUESTS CLEAR:</COL>\nAUTO KILL " .. (enableKill and "<COLOR FF71CE>ENABLED</COL>" or "<COLOR 01CDFE>DISABLED</COL>") .. ".",
            2289944406)
    end

    -- END
    if hwKB ~= nil and hwKB:call("getTrg", 35) then
        enablePartsBreak = not enablePartsBreak
        chatManager:call(
            "reqAddChatInfomation",
            "<COLOR 05FFA1>ONE KEY QUESTS CLEAR:</COL>\nPARTS BREAK " .. (enablePartsBreak and "<COLOR FF71CE>ENABLED</COL>" or "<COLOR 01CDFE>DISABLED</COL>") .. ".",
            2289944406)
    end

    -- PAGE UP
    if hwKB ~= nil and hwKB:call("getTrg", 33) then
        disableAll()
        if settings.modeId >= #modes then
            settings.modeId = 1
        else
            settings.modeId = settings.modeId + 1
        end
        save_settings()
        chatManager:call(
            "reqAddChatInfomation",
            "<COLOR 05FFA1>ONE KEY QUESTS CLEAR:</COL>\nMODE: <COLOR FFFB96>" .. modes[settings.modeId] .. "<COL>.",
            2289944406)
    end

    if settings.separateWindow then
        if imgui.begin_window("OneKeyQuestClear") then
            drawUI()
            imgui.end_window()
        end
    end
    imgui.pop_font()
end)


re.on_draw_ui(function()
    if imgui.tree_node("OneKeyQuestClear - Press DEL Key") then
        drawUI()
        imgui.tree_pop();
    end
end)


local function pre_enemy_update(args)
    -- args[1] = thread_context
    -- args[2] = "this"/object pointer
    -- rest of args are the actual parameters
    local enemy = sdk.to_managed_object(args[2])
    local monsterId = enemy:call("get_UniqueId")

    if enemy == nil then
        debug = "no enemy"
        return args
    end

    -- 1: "Zako Only",
    -- 2: "Perserve Quest Target(s)",
    -- 3: "Camera Selected Target",
    -- 4: "Quest Target(s) Only",
    -- 5: "Target All"
    if settings.modeId == 4 then
        if not enemy:call("isQuestTargetEnemy") then
            return args
        end
    end

    if settings.modeId == 2 then
        if enemy:call("isQuestTargetEnemy") then
            return args
        end
    end

    if settings.modeId == 3 then
        local cameraManager = sdk.get_managed_singleton("snow.CameraManager")
        if cameraManager == nil then
            return args
        end
        local targetCam = cameraManager:call("get_RefTargetCameraManager")
        if targetCam == nil then
            return args
        end

        local camEnemy = targetCam:call("GetTargetEnemy")
        if camEnemy == nil then
            return args
        end

        if camEnemy:call("get_UniqueId") ~= monsterId then
            return args
        end
    end

    if settings.modeId == 1 then
        if enemy:call("get_isBossEnemy") then
            return args
        end
    end

    -- parts break
    -- only try to break when it's bossEnemy
    if (enablePartsBreak or (settings.breakPartsOnKill and enableKill)) and enemy:call("get_isBossEnemy") then
        local damageParam = enemy:call("get_DamageParam")

        local partloss = enemy:get_field("<RefPartsLossHagiPopBehavior>k__BackingField")
        local partInfo = damageParam
            :get_field("_EnemyPartsDamageInfo")
            :call("get_PartsInfo")
            :get_elements()

        local physField = enemy:call("get_PhysicalParam")
        if physField == nil then
            debug = "no phy"
            return args
        end

        for idx, part in pairs(partInfo) do
            local breaklevel = part:call("get_PartsBreakDamageLevel")
            local breaklevelmax = part:call("get_PartsBreakDamageMaxLevel")
            local partVitalParam = physField:call("getVital", 3, idx - 1)

            if partVitalParam:call("get_Max") > 0 then
                breaklevelmax = 1
                breaklevel = partloss:call("get_Item", 0)
                breaklevel = (breaklevel:call("get_IsStart")) and 1 or 0
                if breaklevel < breaklevelmax then
                    enemy:call("setPartsBreak", idx - 1)
                    enemy:call("setPartsLoss", idx - 1)
                end
            elseif breaklevel < breaklevelmax then
                enemy:call("setPartsBreak", idx - 1)
            end
        end
    end

    -- enemy kill
    local questType = questManager:get_field("_QuestType")
    if enableKill and (questType ~= 4 or settings.modeId == 2) then

        local physParam = enemy:call("get_PhysicalParam")
        if not physParam then
            return args
        end

        local vitalParam = physParam:call("getVital", 0, 0)
        if not vitalParam then
            return args
        end

        local enemyType = enemy:get_field("<EnemyType>k__BackingField")
        if not enemyType then
            return args
        end

        local enemyType = enemy:get_field("<EnemyType>k__BackingField")
        if not enemyType then
            return args
        end

        -- is alive
        if vitalParam:call("get_Current") > vitalParam:call("get_Min") then
            -- if not messageManager then
            --     messageManager = sdk.get_managed_singleton("snow.gui.MessageManager")
            --     if not messageManager then
            --         return nil
            --     end
            -- end

            -- init if new monster
            if not killIds[monsterId] then
                killIds[monsterId] = {
                    lastAttempt = nil,
                    min = 0,
                    -- name = tostring(messageManager:call("getEnemyNameMessage", enemyType)), -- debug
                    -- attempts = 0, -- debug
                }
            end
            

            killIds[monsterId].min = vitalParam:call("get_Min")
            
            -- wait for cooldown if attempt was made 
            if killIds[monsterId].lastAttempt ~= nil and getTime() -  killIds[monsterId].lastAttempt < 5 then
                return args
            end
    
            -- try kill
            vitalParam:call("set_Current", killIds[monsterId].min + 1)
            -- if vitalParam:call("get_Current") == killIds[monsterId].min then
            enemy:call("dieSelf")
            -- end

            if questManager:call("isHyakuryuQuest") then
                local hyakuryuParam = enemy:call("get_HyakuryuParam")
                if hyakuryuParam then
                    hyakuryuParam:call("set_IsExitMarionetteBonus", false)
                    hyakuryuParam:call("set_IsMarionetteDone", true)
                end
            end

            -- update last attempt time
            killIds[monsterId].lastAttempt = getTime()
            -- killIds[monsterId].attempts = killIds[monsterId].attempts + 1 -- debug
        end
    end
    return args
end

local function post_enemy_update(retval)
    return retval
end

sdk.hook(
    sdk.find_type_definition("snow.enemy.EnemyCharacterBase"):get_method("update"),
    pre_enemy_update,
    post_enemy_update
)

-- skip mario
-- sdk.hook(
--     sdk.find_type_definition("snow.enemy.EnemyMarionetteStartDamageParam"):get_method("setup"),
--     function (args)
--         return sdk.PreHookResult.SKIP_ORIGINAL
--     end,
--     function (args)
--         return sdk.to_ptr(0)
--     end
-- )
