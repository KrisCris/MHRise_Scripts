-- https://github.com/KrisCris/MHRise_Scripts/blob/main/autorun/AutoVillage.lua
-- Re-uploading my code/files somewhere else is strictly forbidden.
-- 不要把我的代码/文件转载至其他地方
---@diagnostic disable: undefined-global

local settings = {
    enabled = true
}

local function save_settings()
    json.dump_file("AutoVillage.json", settings)
end

local function load_settings()
    local loadedTable = json.load_file("AutoVillage.json")
    if loadedTable ~= nil then
        settings = loadedTable
        return
    end
    save_settings()
end

load_settings()

local function autoVillage()
    if not settings.enabled then
        return
    end
    local progressOtomoTicketManager = sdk.get_managed_singleton("snow.progress.ProgressOtomoTicketManager")
    progressOtomoTicketManager:call("supply")

    -- local progressGoodRewardManager = sdk.get_managed_singleton("snow.progress.ProgressGoodRewardManager")
    -- if progressGoodRewardManager:call("checkReward") then
    --     progressGoodRewardManager:call("supplyReward")
    --     local chatManager = sdk.get_managed_singleton("snow.gui.ChatManager")
    --     chatManager:call("reqAddChatInfomation", "<COLOR 05FFA1>test</COL>", 2412657311)
    -- end
    
    local progressTicketSupplyManager = sdk.get_managed_singleton("snow.progress.ProgressTicketSupplyManager")
    for i = 0, 4 do
        if progressTicketSupplyManager:call("isEnableSupply", i) then
            progressTicketSupplyManager:call("supply", i)
        end
    end

    local progressOwlNestManager = sdk.get_managed_singleton("snow.progress.ProgressOwlNestManager")
    local owlNestSaveData = progressOwlNestManager:get_field("<SaveData>k__BackingField")
    local villageAreaManager = sdk.get_managed_singleton("snow.VillageAreaManager")
    local areaNo = villageAreaManager:call("get__CurrentAreaNo")
    if areaNo >= 6 and owlNestSaveData:get_field("_StackCount2") >= 5 then
        progressOwlNestManager:call("supply")
    end
    if areaNo < 6 and owlNestSaveData:get_field("_StackCount") >= 5 then
        progressOwlNestManager:call("supply")
    end
end
sdk.hook(sdk.find_type_definition("snow.VillageMapManager"):get_method("getCurrentMapNo"),
	nil,
	autoVillage)


re.on_draw_ui(function()
    if imgui.tree_node("AutoVillage") then
        if imgui.checkbox("Enabled", settings.enabled) then
            settings.enabled = not settings.enabled
            save_settings()
        end
        imgui.tree_pop();
    end
end)