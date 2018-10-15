function isCrafting(stor,itemStack)
    for i,task in ipairs(stor.getTasks()) do
        for j,outputs in ipairs(task.pattern.outputs) do
            if ((string.find(outputs.name,itemStack.name) ~= nil) and (tonumber(outputs.damage) == itemStack.damage)) then
                return(true)
            end
        end
    end
    return(false)
end

local component = require("component")
local os = require("os")
stor = component.proxy(component.get("526"))

items = {
    {label="Lapis Lazuli",max_quantity=700,min_quantity=500,name="dye",damage=4,block_name="lapis_block",block_damage=0,block_size=9},
    {label="Tin Ingot",max_quantity=300,min_quantity=100,name="thermalfoundation:material",damage=129,block_name="thermalfoundation:storage",block_damage=1,block_size=9},
    {label="Coal",max_quantity=700,min_quantity=500,name="coal",damage=0,block_name="coal_block",block_damage=0,block_size=9},
    {label="Redstone",max_quantity=1000,min_quantity=700,name="redstone",damage=0,block_name="redstone_block",block_damage=0,block_size=9},
    {label="Lead Ingot",max_quantity=300,min_quantity=100,name="thermalfoundation:material",damage=131,block_name="thermalfoundation:storage",block_damage=3,block_size=9},
    {label="Silver Ingot",max_quantity=300,min_quantity=100,name="thermalfoundation:material",damage=130,block_name="thermalfoundation:storage",block_damage=2,block_size=9},
    {label="Aluminum Ingot",max_quantity=300,min_quantity=100,name="thermalfoundation:material",damage=132,block_name="thermalfoundation:storage",block_damage=4,block_size=9},
    {label="Iron Ingot",max_quantity=700,min_quantity=500,name="iron_ingot",damage=0,block_name="iron_block",block_damage=0,block_size=9},
    {label="Copper Ingot",max_quantity=300,min_quantity=100,name="thermalfoundation:material",damage=128,block_name="thermalfoundation:storage",block_damage=0,block_size=9},
    {label="Gold Ingot",max_quantity=300,min_quantity=100,name="gold_ingot",damage=0,block_name="gold_block",block_damage=0,block_size=9}
}

while true do
    for i,item in ipairs(items) do
        itemStack = {name=item.name,damage=item.damage}
        blockStack = {name=item.block_name,damage=item.block_damage}    
        quantityInStorage = stor.getItem(itemStack).size
        print("Checking: "..item.label)

        if (quantityInStorage > item.max_quantity) then
            print(quantityInStorage - item.max_quantity.." "..item.label.." to block")
            if (isCrafting(stor,blockStack) == false) then
                if (item.block_size == 0) then
                    print("Error: Spezify block size for item",item.name)
                else
                    toCraft = math.floor((quantityInStorage - item.max_quantity) / item.block_size + 1)
                    print("Blocking: "..(toCraft * 9).." "..item.label)
                    stor.scheduleTask(blockStack,toCraft)
                end
            end
        end

        if (quantityInStorage < item.min_quantity) then
            toCraft = item.min_quantity - quantityInStorage
            print(toCraft.." " ..item.label.." to unblock")
            if (isCrafting(stor,itemStack) == false) then            
                print("Unblocking: ",(toCraft * 9).." "..item.label)
                stor.scheduleTask(itemStack,toCraft)
            end
        end
    end

    os.sleep(10)
end
