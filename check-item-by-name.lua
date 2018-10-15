local component = require("component")
stor = component.proxy(component.get("526"))

itemName = "Tin"

for i,item in ipairs(stor.getItems()) do
    if (string.find(item.label,itemName) ~= nil) then
        print(item.label,item.name,item.damage,item.size)
    end
end
