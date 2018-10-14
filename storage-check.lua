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

print("Energy Usage:",energy)

print("Items Stored:",totalUseItem,"/",totalCapItem,":",totalUseItem / totalCapItem * 100,"%")
print("Items Stored:",totalUseLiq,"/",totalCapLiq,":",totalUseLiq / totalCapLiq * 100,"%")
