local plugin_configs = {
    "compe", "nvimtree"
}

for _, plugin in ipairs(plugin_configs) do
    require("config/"..plugin)
end



