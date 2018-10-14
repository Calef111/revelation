local component = require("component")

stor = component.proxy(component.get("526"))

energy = stor.getEnergyUsage()
devs = stor.getStorages()

print("Energy Usage:",energy)
print("Devices:\n",devs)
