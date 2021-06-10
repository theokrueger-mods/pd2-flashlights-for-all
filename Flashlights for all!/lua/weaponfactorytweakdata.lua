-- add our custom model, unit, and cooked_physics
-- not doing it iteratively since i am lazy, sorry everyone.
local entries = {
	-- format: extension, inpath, path
	{"cooked_physics", "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free", ModPath.."assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.cooked_physics"},
	{"model", "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free", ModPath.."assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.model"},
	{"object", "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free", ModPath.."assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.object"},
	{"unit", "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free", ModPath.."assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.unit"}
}
for _, v in pairs(entries) do
    BLTAssetManager:CreateEntry(Idstring(v[2]), Idstring(v[1]), v[3], nil) -- NOTE this may require an update as CreateEntry gets a settings
end

-- add our attachment
Hooks:PostHook(WeaponFactoryTweakData, "init", "FFA_init", function(self)
    for k, _ in pairs(self) do
        if self[k].uses_parts and self[k].default_blueprint then
            -- sadly have to put it into uses parts and default since otherwise weapon dies on relaunch
            table.insert(self[k].default_blueprint, "wpn_fps_upg_fl_free")
            table.insert(self[k].uses_parts, "wpn_fps_upg_fl_free")
        end
    end
    self.parts.wpn_fps_upg_fl_free = {
        is_a_unlockable = nil,
        type = "gadget",
        a_obj = "a_b",
        sub_type = "laser",
        name_id = "",
        unit = "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free", -- our custom unit
        pcs = nil,
        stats = {
            value = 1
        },
        perks = {"gadget"},
        adds = {"wpn_fps_upg_fl_ass_peq15_flashlight"}
    }
end)
