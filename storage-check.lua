function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local component = require("component")

stor = component.proxy(component.get("526"))

energy = stor.getEnergyUsage()
devs = stor.getStorages()

totalCapItem = 0
totalUseItem = 0
totalCapLiq = 0
totalUseLiq = 0
for i = 1,#devs.devices,1 do
    if (devs.devices[i].type == "item") then
        totalCapItem = totalCapItem + devs.devices[i].capacity
        totalUseItem = totalUseItem + devs.devices[i].usage
    else
        totalCapLiq = totalCapLiq + devs.devices[i].capacity
        totalUseLiq = totalUseLiq + devs.devices[i].usage
    end
end

print("Energy Usage:",round(energy/1000,2) + "kRF/T"

print("Items Stored:",round(totalUseItem / 1000,2) + "k","/",round(totalCapItem / 1000,2) + "k",":",round(totalUseItem / totalCapItem * 100,2) + "%")
print("Items Stored:",round(totalUseLiq / 1000,2) + "k","/",round(totalCapLiq / 1000,2) + "k",":",round(totalUseLiq / totalCapLiq * 100,2) + "%")
