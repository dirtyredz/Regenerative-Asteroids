
package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
package.path = package.path .. ";configs/?.lua"

SectorGenerator = require ("SectorGenerator")
OperationExodus = require ("story/operationexodus")
Placer = require("placer")
require("RegenerativeAsteroidsConfig")

local SectorTemplate = {}
SectorTemplate.CustomName = 'Regenerative Asteroids'

-- must be defined, will be used to get the probability of this sector
function SectorTemplate.getProbabilityWeight(x, y)
    return RegenerativeAsteroidsConfig.frequency
end

function SectorTemplate.offgrid(x, y)
    return true
end

-- this function returns whether or not a sector should have space gates
function SectorTemplate.gates(x, y)
    return false
end

-- player is the player who triggered the creation of the sector (only set in start sector, otherwise nil)
function SectorTemplate.generate(player, seed, x, y)
    math.randomseed(seed)

    local generator = SectorGenerator(x, y)

    local numFields = math.random(2, 5)
    for i = 1, numFields do
        local position = generator:createAsteroidField(0.075);
        if math.random() < 0.35 then generator:createBigAsteroid(position) end
    end

    for i = 1, 5 - numFields do
        local position = generator:createEmptyAsteroidField();
        if math.random() < 0.5 then generator:createEmptyBigAsteroid(position) end
    end

    local numSmallFields = math.random(8, 15)
    for i = 1, numSmallFields do
        local mat = generator:createSmallAsteroidField()

        if math.random() < 0.2 then generator:createStash(mat) end
    end

    Sector():addScript("data/scripts/sector/events.lua", "events/pirateattack.lua")

    generator:addOffgridAmbientEvents()

    --Added by dirtyredz
    Sector():addScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")

    Placer.resolveIntersections()
end

return SectorTemplate
