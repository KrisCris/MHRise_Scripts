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