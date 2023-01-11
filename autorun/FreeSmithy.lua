-- https://github.com/KrisCris/MHRise_Scripts/blob/main/autorun/FreeSmithy.lua
-- Re-uploading my code/files somewhere else is strictly forbidden.
-- 不要把我的代码/文件转载至其他地方
---@diagnostic disable: undefined-global

local settings = {
    NoRecipe = true,
    Free = true,
    UnlockAll = false
}

local function save_settings()
    json.dump_file("FreeSmithy.json", settings)
end

local function load_settings()
    local loadedTable = json.load_file("FreeSmithy.json")
    if loadedTable ~= nil then
        settings = loadedTable
        return
    end
    save_settings()
end

load_settings()

re.on_draw_ui(function()
    if imgui.tree_node("FreeSmithy") then
        if imgui.checkbox("No Recipe", settings.NoRecipe) then
            settings.NoRecipe = not settings.NoRecipe
            save_settings()
        end

        if imgui.checkbox("Free", settings.Free) then
            settings.Free = not settings.Free
            save_settings()
        end

        if imgui.checkbox("Unlock All", settings.UnlockAll) then
            settings.UnlockAll = not settings.UnlockAll
            save_settings()
        end
        imgui.tree_pop();
    end
end)

sdk.hook(
    sdk.find_type_definition("snow.data.RecipeItemList"):get_method("getItem"),
    function (args)
        return args
    end,
    function (retval)
        if settings.NoRecipe then
            local element = sdk.to_managed_object(retval)
            element:get_field("ItemId")
            element:set_field("ItemNum", 0)
        end

        return retval
    end
)

sdk.hook(
    sdk.find_type_definition("snow.data.EquipRecipeData"):get_method("isUnlocked"),
    function (args)
        return args
    end,
    function (retval)
       if settings.UnlockAll then
            return sdk.to_ptr(1)
       end
       return retval
    end
)

-- sdk.hook(
--     sdk.find_type_definition("snow.data.SmithyFacilityCraftSystem"):get_method("getCategoryMaterialPoint"),
--     function (args)
--         return args
--     end,
--     function (retval)
--         return sdk.to_ptr(0)
--     end
-- )


sdk.hook(
    sdk.find_type_definition("snow.data.PlEquipMakingData"):get_method("get_ProductVal"),
    function (args)
        return args
    end,
    function (retval)
        if settings.Free then
            return sdk.to_ptr(0)
        end
       return retval
    end
)