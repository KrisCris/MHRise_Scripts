-- NOTE: You have to pay for Paid DLCs. It's considered piracy if you do not own any of the items unlocked by the script.
-- Re-uploading my code/files somewhere else is strictly forbidden.
-- 不要把我的代码/文件转载至其他地方

---@diagnostic disable: undefined-global

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


-- sdk.hook(
-- 	sdk.find_type_definition("snow.DlcManager"):get_method("recvDlc(snow.DlcManager.DlcInfo, System.Int64)"),
-- 	function(args)
-- 		return args
-- 	end,
-- 	function(retval)
-- 		log.debug("[RecvDLC RET] " .. tostring(sdk.to_managed_object(retval)))
-- 		return retval
-- 	end
-- )

-- sdk.hook(
--     sdk.find_type_definition("snow.ProprietaryDLCMounter"):get_method("requestMount"),
--     function (args)
--         log.info("[snow.ProprietaryDLCMounter]"..tostring(args[2]))
--     end,
--     function (retval)
--         return retval
--     end
-- )

-- sdk.hook(
-- 	sdk.find_type_definition("snow.DlcManager"):get_method("getRefundedDlc"),
-- 	function(args)
-- 		-- return sdk.PreHookResult.SKIP_ORIGINAL
-- 	end,
-- 	function(retval)
-- 		for i = 0, retval:call("get_Count") - 1 do
-- 			log.info("[DLC_TEST] "..retval:call("get_Item", i):get_field("dlcID"))
-- 		end
-- 		return retval:call("Clear")
-- 	end
-- )

-- prevent dlc removal


-- Disable Refund
sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundPlOverWear"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundPlOverWearWeapon"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundOtmOverWear"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundOwlCostume"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundStamp_Gesture_Poseset"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundHairStyle_Paint_Voice"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundBGM"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundDogCommand"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("refundVerifySystemData"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("reqRefundVerification"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(true)
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("set_IsRequiredRefundSave"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("set_IsRequiredRefundSystemSave"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return retval
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("get_IsRequiredRefundSave"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(false)
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("get_IsRequiredRefundSystemSave"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(false)
	end
)


-- sdk.hook(
-- 	sdk.find_type_definition("snow.DlcManager"):get_method("isCanUsedDlc"),
-- 	function(args)
-- 		return sdk.PreHookResult.SKIP_ORIGINAL
-- 	end,
-- 	function(retval)
-- 		return sdk.to_ptr(true)
-- 	end
-- )

-- sdk.hook(
-- 	sdk.find_type_definition("snow.DlcManager"):get_method("isInvalidDlc"),
-- 	function(args)
-- 		return sdk.PreHookResult.SKIP_ORIGINAL
-- 	end,
-- 	function(retval)
-- 		return sdk.to_ptr(false)
-- 	end
-- )

-- This method checks if your save can be loaded as a MR player
sdk.hook(
	sdk.find_type_definition("snow.DlcMounter"):get_method("hasMrRight"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(true)
	end
)


-- checks if the dlc is unlocked, e.g. hair style
sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("isCanUsedDlc"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(true)
	end
)

-- checks if the save is eligible to use DLC contents, e.g. hair style
sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("isCanUsedSaveLinkContents"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(true)
	end
)


sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("isInvalidDlc"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(false)
	end
)

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("getCharaMakeTicketMax"),
	function(args)
		return sdk.PreHookResult.SKIP_ORIGINAL
	end,
	function(retval)
		return sdk.to_ptr(1000)
	end
)

local showAllDLCs = false
local ignore = false
local managedRetval = nil
local DlcManager = sdk.get_managed_singleton("snow.DlcManager")

sdk.hook(
	sdk.find_type_definition("snow.DlcManager"):get_method("getDownloadDlcDataList"),
	function(args)
		return args
	end,
	function(retval)
		if showAllDLCs then
			if not DlcManager then
				DlcManager = sdk.get_managed_singleton("snow.DlcManager")
			end

			managedRetval = sdk.to_managed_object(retval)
			local dlcDataList = DlcManager:get_field("_DlcList"):get_field("_DataList")
			managedRetval:call("Clear")
			for i = 0, dlcDataList:call("get_Count") - 1 do
				local dlcData = dlcDataList:call("get_Item", i)
				local dlcCate = dlcData:get_field("_sortCategory")
				if dlcCate ~= 20 and dlcCate ~= 22 then
					-- log.debug("ids"..tostring(dlcData:get_field("_sortCategory")))
					local dlcInfo = sdk.find_type_definition("snow.DlcManager.DlcInfo"):create_instance()
					dlcInfo:call("makeInfo", dlcData)
					managedRetval:call("Add", dlcInfo)
				end
			end
			DlcManager:call("sortDlcList", retval, 21)
		end
		return retval
	end
)
-- local count = 0
re.on_draw_ui(function()
	if imgui.tree_node("DLC Unlocker") then
		-- count = 0
		imgui.push_font(font)

		if imgui.checkbox("Display All DLCs", showAllDLCs) then
			showAllDLCs = not showAllDLCs
		end
		-- if retel then
		-- 	for i = 0, retel:call("get_Count") - 1 do
		-- 		local dlcInfo = retel:call("get_Item", i)
		-- 		-- imgui.text(dlcInfo:get_field("translatedName"))
		-- 		imgui.text(tostring(dlcInfo:get_field("needVersion")))
		-- 		if dlcInfo:get_field("needVersion") then
		-- 			count = count + 1
		-- 		end
		-- 	end
		-- end
		-- imgui.text("[needVersions]"..count)
		imgui.pop_font()
		imgui.tree_pop();
	end
end)

-- snow.DlcManager.DlcInfo::dlcID
-- snow.DlcManager.DlcInfo::getDLItemPackTitle()
-- snow.DlcManager::getDownloadDlcDataList() -> snow.DlcManager.DlcInfo
-- local dlcList = sdk.get_managed_singleton("snow.DlcManager"):call("getDownloadDlcDataList")
-- getDLItemPackTitle()

-- local dlcManager = sdk.get_managed_singleton("snow.DlcManager")
-- if dlcManager ~= nil then
-- 	local steamDlcList = dlcManager:get_field("<_StmDlcSortedSubList>k__BackingField"):get_elements()
-- 	local counter = 0	for i, stmDlcSubData in pairs(steamDlcList) do
-- 		local id = stmDlcSubData:get_field("_id")
-- 		local appid = stmDlcSubData:get_field("_appId")
-- 		local refundable = stmDlcSubData:get_field("_refundable")

-- 		if refundable then
-- 			counter = counter + 1
-- 			log.debug("id="..id.."  appid="..appid.."  refundable="..tostring(refundable).."  #"..counter)
-- 		end

-- 	end
-- 	local dlcList = dlcManager:call("getRefundedDlc")
-- 	local dlcCount = dlcList:call("get_Count")
-- 	log.debug("dlcCount=" .. tostring(dlcCount))

-- for i = 0, dlcCount - 1, 1 do
-- 	-- local dlcTitle = dlcList:call("get_Item", i):call("getDLItemPackTitle")
-- 	local dlcInfo = dlcList:call("get_Item", i)
-- 	local dlcId = dlcInfo:get_field("dlcID")
-- 	log.debug("dlcId=" .. dlcId)
-- 	local ret = dlcManager:call("setRecvDlc", dlcInfo, 0)
-- 	-- log.debug("status:"..tostring(ret:read_byte()))

-- 	-- log.debug("dlcTitle="..dlcTitle)
-- end
-- end
