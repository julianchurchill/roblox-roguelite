local module = {}

local collectionService = game:GetService("CollectionService")

function module.SetupBehaviour(tag, addBehaviourFunction)
    -- add behaviour to new objects that get the tag added
    local function onTaggedInstanceAdded(object)
        addBehaviourFunction(object)
    end

    collectionService:GetInstanceAddedSignal(tag):Connect(onTaggedInstanceAdded)

    -- ensure any pre-existing objects with the tag have the behaviour added too
    for _, object in pairs(collectionService:GetTagged(tag)) do
        onTaggedInstanceAdded(object)
    end
end

return module