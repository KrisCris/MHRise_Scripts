local numRes = 10
local doAlchemy = false

re.on_draw_ui(function ()
    imgui.text("Go! Alchemy!!")
    changed, numRes = imgui.slider_int("", numRes, 1, 10)
    if imgui.button("Boom") then
        doAlchemy = true
    end
end)

re.on_pre_application_entry("UpdateBehavior", function ()
    if doAlchemy then
        local fm = sdk.get_managed_singleton("snow.data.FacilityDataManager")
        local alchemy = fm:call("getAlchemy")
        local count = numRes
        while alchemy:call("getRemainingSlotNum") > 0 and count > 0 do
            count = count - 1
            local dm = sdk.get_managed_singleton("snow.data.DataManager")
            local ib = dm:call("get_PlItemBox")
            ib:call("tryAddGameItem(snow.data.ContentsIdSystem.ItemId, System.Int32)", 68158506, 19)
            local list = alchemy:call("getPatturnDataList"):call("ToArray")
            alchemy:call("selectPatturn", list[3])
            alchemy:call("addUsingItem", 68158506, 19)
            alchemy:call("reserveAlchemy")
            alchemy:call("invokeCycleMethod")
        end
        doAlchemy = false
    end
end)