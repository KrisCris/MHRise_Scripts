-- NOTE: You have to pay for Paid DLCs. It's considered piracy if you do not own any of the items unlocked by the script.

-- prevent dlc items removal
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


-- This method checks if the MR save can be used when loading the save
-- so you are still able to play the game if Denuvo DLC encryption is working false positively
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

-- snow.DlcManager.DlcInfo::dlcID
-- snow.DlcManager.DlcInfo::getDLItemPackTitle()
-- snow.DlcManager::getDownloadDlcDataList() -> snow.DlcManager.DlcInfo
-- local dlcList = sdk.get_managed_singleton("snow.DlcManager"):call("getDownloadDlcDataList")


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
