-----------------------------------------
-- ID: 16227
-- Persikos Tank
-- When used, you will obtain one Persikos au lait
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:getFreeSlotsCount() == 0) then
        result = 308
    end
    return result
end

function onItemUse(target)
    target:addItem(4303,1)
end