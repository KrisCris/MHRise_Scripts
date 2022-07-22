local numRes = 10
local doAlchemy = false

re.on_draw_ui(function ()
    if imgui.tree_node("Go Alchemy!") then
        changed, numRes = imgui.slider_int("Count", numRes, 1, 10)
        if imgui.button("Boom") then
            doAlchemy = true
        end
        imgui.tree_pop()
    end
end)

re.on_pre_application_entry("UpdateBehavior", function ()
    if doAlchemy then
        local count = numRes

        local FacilityDataManager = sdk.get_managed_singleton("snow.data.FacilityDataManager")
        local AlchemyFacility = FacilityDataManager:call("getAlchemy")
        local PatturnDataList = AlchemyFacility:call("getPatturnDataList"):call("ToArray")
        -- set kamura cost to 0
        PatturnDataList[3]:get_field("_Param"):set_field("_CostVillagePoint", 0)
        while AlchemyFacility:call("getRemainingSlotNum") > 0 and count > 0 do
            count = count - 1
            -- insert items for alchemy
            local dm = sdk.get_managed_singleton("snow.data.DataManager")
            local ib = dm:call("get_PlItemBox")
            ib:call("tryAddGameItem(snow.data.ContentsIdSystem.ItemId, System.Int32)", 68158506, 25)
            -- select 5th alchemy
            AlchemyFacility:call("selectPatturn", PatturnDataList[5])
            -- use the item added
            AlchemyFacility:call("addUsingItem", 68158506, 25)
            AlchemyFacility:call("reserveAlchemy")
            AlchemyFacility:call("invokeCycleMethod")
        end
        doAlchemy = false

    end
end)