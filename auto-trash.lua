local component = require("component")
local os = require("os")
stor = component.proxy(component.get("dbb"))

globalTrashAboveAmount = 3000

customSettings = {
    {label="Nether Quartz",name="minecraft:quartz",damage=0,trashAboveAmount=8000},
    {label="Refined Uranium",name="ic2:ingot",damage=8,trashAboveAmount=20000}
}

while true
    for i,item in ipairs(stor.getItems()) do
        trashAboveAmount = globalTrashAboveAmount
        for j,cust in ipairs(customSettings) do
            if ((string.find(item.name,cust.name) ~= nil) and (tonumber(item.damage) == cust.damage)) then
                trashAboveAmount = cust.trashAboveAmount
            end
        end
        inStore = tonumber(item.size)
        if (inStore > trashAboveAmount) then
            toTrash = inStore - trashAboveAmount
            print(item.label,item.size,"To Trash:"..(toTrash))
            if (toTrash > item.maxSize) then
                stacksToTrash = math.floor(toTrash / item.maxSize)
                for k=1,stacksToTrash,1 do
                    stor.extractItem({name=item.name,damage=item.damage},item.maxSize,0)
                    toTrash = toTrash - item.maxSize
                end
            end
            if (toTrash > 0) then
                stor.extractItem({name=item.name,damage=item.damage},toTrash,0)
            end
        end
    end

    print("Operation finished\n\n\n")
    os.sleep(120)
end
