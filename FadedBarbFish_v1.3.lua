-- 02.09.24 v1.3 by xyFaded
-- Requirements: Level 20+ fishing, feathers in inventory, Barbarian Village fishing spot

local API = require("api")

local MAX_IDLE_TIME_MINUTES = 5
API.SetMaxIdleTime(MAX_IDLE_TIME_MINUTES)

local ID = {
    328
}

local ITEMS = {
    331,
    335
}

local function countInv()
    for _, item in ipairs(ITEMS) do
        local count = API.InvItemcount_2(item)
        if count > 0 then
            for i = 0, count, 1 do
                API.DoAction_Inventory1(item, 0, 8, API.OFF_ACT_GeneralInterface_route2)
                API.RandomSleep2(500, 500, 1000)
            end
        end
    end
end

local function barbFish()
    while not API.InvFull_() do
        local feathers = API.InvItemcount_2(314)
        local isFishing = (API.ReadPlayerAnim() == 24928)

        if not isFishing and feathers ~= 0 then
            print("Not fishing. Looking for new spot.")
            API.RandomSleep2(2000, 1000, 2000)
            API.DoAction_NPC(0x3c,API.OFF_ACT_InteractNPC_route,ID,50)
            API.RandomSleep2(5000, 1000, 2000)
        elseif isFishing then
            print("Fishing.")
            API.RandomSleep2(5000, 1000, 2000)
        elseif feathers == 0 then
            print("No feathers in inventory.")
            API.Write_LoopyLoop(false)
            return
        end
    end

    print("Inventory full")
    API.RandomSleep2(2000, 1000, 2000)
end

while API.Read_LoopyLoop() do  
    barbFish()
    countInv()
end

--[[====[
NEED TO ADD
- Make the stop button ALWAYS work and not just at the end of loop

CHANGELOG
02.09.24 v1.3 - Changed idle function. Thanks to Dead and 404 Meek
02.09.24 v1.2 - Scrapped rebanking, cleaned up code
01.09.24 v1.1 - Now checks if there are feathers in the inventory
01.09.24 v1   - Initial release
--]====]]