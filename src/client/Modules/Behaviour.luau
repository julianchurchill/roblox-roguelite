local module = {}

local collectionService = game:GetService("CollectionService")

function module.SetupBehaviour(tag, behaviourFunction)
    -- add behaviour to new objects that get the tag added
    local function onAttackableInstanceAdded(object)
        behaviourFunction(object)
    end

    collectionService:GetInstanceAddedSignal(tag):Connect(onAttackableInstanceAdded)

    -- ensure any pre-existing objects with the tag have the behaviour added too
    for _, object in pairs(collectionService:GetTagged(tag)) do
        onAttackableInstanceAdded(object)
    end
end

return module