
package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
package.path = package.path .. ";configs/?.lua"

SectorGenerator = require ("SectorGenerator")
Placer = require("placer")
require("RegenerativeAsteroidsConfig")

local SectorTemplate = {}

-- must be defined, will be used to get the probability of this sector
function SectorTemplate.getProbabilityWeight(x, y)
    return 500
end

function SectorTemplate.offgrid(x, y)
    return false
end

-- this function returns whether or not a sector should have space gates
function SectorTemplate.gates(x, y)
    return true
end

-- player is the player who triggered the creation of the sector (only set in start sector, otherwise nil)
function SectorTemplate.generate(player, seed, x, y)
    math.randomseed(seed);

    local generator = SectorGenerator(x, y)

    local faction = Galaxy():getLocalFaction(x, y) or Galaxy():getNearestFaction(x, y)

    generator:createStation(faction, "data/scripts/entity/merchants/resourcetrader.lua");
    generator:createStation(faction, "data/scripts/entity/merchants/tradingpost.lua");
    generator:createRepairDock(faction);

    -- create trading posts from other factions
    local otherFactions = {}
    otherFactions[faction.index] = true

    for i = 1, 10 do
        local otherFaction = Galaxy():getNearestFaction(x + math.random(-15, 15), y + math.random(-15, 15))

        if otherFaction and not otherFactions[otherFaction.index] then
            otherFactions[otherFaction.index] = true

            if faction:getRelations(otherFaction.index) > -20000 then
                generator:createStation(otherFaction, "data/scripts/entity/merchants/tradingpost.lua");
            end
        end
    end

    -- maybe create some asteroids
    local numFields = math.random(0, 1)
    for i = 1, numFields do
        local pos = generator:createEmptyAsteroidField();
        if math.random() < 0.4 then generator:createEmptyBigAsteroid(pos) end
    end

    numFields = math.random(0, 1)
    for i = 1, numFields do
        local pos = generator:createAsteroidField();
        if math.random() < 0.4 then generator:createBigAsteroid(pos) end
    end

    -- create defenders
    local defenders = math.random(4, 6)
    for i = 1, defenders do
        ShipGenerator.createDefender(faction, generator:getPositionInSector())
    end

    local numSmallFields = math.random(0, 5)
    for i = 1, numSmallFields do
        generator:createSmallAsteroidField()
    end

    if SectorTemplate.gates(x, y) then generator:createGates() end

    if math.random() < generator:getWormHoleProbability() then generator:createRandomWormHole() end

    Sector():addScript("data/scripts/sector/events.lua")
    generator:addAmbientEvents()

    -- this one is added last since it will adjust the events that have been added
    Sector():addScript("data/scripts/sector/neutralzone.lua")

    --Begin Added by RegenerativeAsteroids - Dirtyredz
    if RegenerativeAsteroidsConfig.NeutralZone then
      Sector():addScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")
    end
    --End Added by RegenerativeAsteroids - Dirtyredz

    Placer.resolveIntersections()
end

return SectorTemplate
