--[[

\ v v v v v v v v v v v v v v v v v v v v v v v /
> PROBABLY A PRETTY IMPORTANT WARNING GOES HERE <
/ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ \

since this inserts itself into the default blueprint of every gun, removing this mod means certain death for every gun without a gadget equipped. sorry.

]]--

-- save mod path as local for too many reasons to list
local mod_path = ModPath

-- list our custom model, unit, and cooked_physics
local entries = {
        -- format: extension, inpath, path
        {
                'cooked_physics',
                'units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free',
                mod_path .. 'assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.cooked_physics'
        },
        {
                'model',
                'units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free',
                mod_path .. 'assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.model'
        },
        {
                'object',
                'units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free',
                mod_path .. 'assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.object'
        },
        {
                'unit',
                'units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free',
                mod_path .. 'assets/units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free.unit'
        }
}

-- add the entries we just listed
for _, v in pairs(entries) do
        -- super handy function (req. SuperBLT) that automatically handles create_entry stuff for linux and windows builds
        BLTAssetManager:CreateEntry(Idstring(v[2]), Idstring(v[1]), v[3], nil)
end

-- add our attachment to the tweakdata
Hooks:PostHook(
        WeaponFactoryTweakData, "init", "FFA_init", function(self)
                -- add attachment to every weapon
                for k, _ in pairs(self) do
                        if self[k].uses_parts and self[k].default_blueprint then
                                -- sadly have to put it into uses parts and default since otherwise weapon dies on relaunch
                                table.insert(self[k].default_blueprint, "wpn_fps_upg_fl_free")
                                table.insert(self[k].uses_parts, "wpn_fps_upg_fl_free")
                        end
                end

                -- create our attachment
                self.parts.wpn_fps_upg_fl_free = {
                        -- hide the attachment from the list of gadgets
                        is_a_unlockable = nil,
                        -- categorise as gadget
                        type = "gadget",
                        -- attachment point is barrel so the laser lines up with the barrel or something
                        a_obj = "a_b",
                        -- no clue what this does but its probably important
                        sub_type = "laser",
                        -- localistation text id, not needed since it doesnt show up in the gui anywhere
                        name_id = "",
                        -- our custom unit
                        unit = "units/mods/weapons/wpn_fps_upg_fl_free/wpn_fps_upg_fl_free",
                        -- additional parts it adds to the gun as a prereq (like gadget rails i think)
                        pcs = nil,
                        -- no idea what this does but it makes it free and not change stats
                        stats = {
                                value = 1
                        },
                        -- allow pressing gadget button to mess with this
                        perks = {
                                "gadget"
                        },
                        -- also has a flashlight, nice!
                        adds = {
                                "wpn_fps_upg_fl_ass_peq15_flashlight"
                        }
                } -- end attachment
        end
)
