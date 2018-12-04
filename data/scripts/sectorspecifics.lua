
package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
package.path = package.path .. ";data/scripts/sectors/?.lua"
package.path = package.path .. ";?.lua"
package.path = package.path .. ";?"

require ("randomext")
FactionsMap = require ("factionsmap")
PassageMap = require ("passagemap")
SectorNameGenerator = require ("sectornamegenerator")
require ("galaxy")

--Begin Added by RegenerativeAsteroids - Dirtyredz
exsist, RegenerativeAsteroidsConfig = pcall(require, 'mods.RegenerativeAsteroids.config.RegenerativeAsteroidsConfig')
local RegenAsteroidsSectorGenerator = RegenerativeAsteroidsConfig.SectorGenerator or true
--End Added by RegenerativeAsteroids - Dirtyredz


local assert = assert
local SectorSpecifics = {}
SectorSpecifics.__index = SectorSpecifics

local function new(x, y, serverSeed)

    local obj = setmetatable({}, SectorSpecifics)

    if x and y and serverSeed then
        obj:initialize(x, y, serverSeed)
    end

    return obj
end

function SectorSpecifics:addTemplate(path)
    local template = require(path)
    template.path = path

    table.insert(self.templates, template)
end

function SectorSpecifics:addTemplates()

    if self.templates then return end
    self.templates = {}

    -- first position is reserved, it's used for faction's home sectors. don't change this
    self:addTemplate("sectors/colony")
    self:addTemplate("sectors/asteroidfieldminer")
    self:addTemplate("sectors/loneconsumer")
    self:addTemplate("sectors/lonescrapyard")
    self:addTemplate("sectors/loneshipyard")
    self:addTemplate("sectors/lonetrader")
    self:addTemplate("sectors/lonetradingpost")
    self:addTemplate("sectors/lonewormhole")
    self:addTemplate("sectors/factoryfield")
    self:addTemplate("sectors/basefactories")
    self:addTemplate("sectors/lowfactories")
    self:addTemplate("sectors/midfactories")
    self:addTemplate("sectors/highfactories")
    self:addTemplate("sectors/miningfield")
    self:addTemplate("sectors/gates")
    self:addTemplate("sectors/ancientgates")
    self:addTemplate("sectors/neutralzone")

    self:addTemplate("sectors/pirateasteroidfield")
    self:addTemplate("sectors/piratefight")
    self:addTemplate("sectors/piratestation")

    --Begin Added by RegenerativeAsteroids - Dirtyredz
    if RegenAsteroidsSectorGenerator == true then
      self:addTemplate("mods/RegenerativeAsteroids/scripts/sectors/RegenerativeAsteroids")
    end
    --End Added by RegenerativeAsteroids - Dirtyredz

    self:addTemplate("sectors/asteroidfield")
    self:addTemplate("sectors/containerfield")
    self:addTemplate("sectors/smallasteroidfield")
    self:addTemplate("sectors/wreckagefield")
    self:addTemplate("sectors/stationwreckage")
    self:addTemplate("sectors/smugglerhideout")
    self:addTemplate("sectors/cultists")
    self:addTemplate("sectors/wreckageasteroidfield")
    self:addTemplate("sectors/researchsatellite")
    self:addTemplate("sectors/functionalwreckage")

    self:addTemplate("sectors/xsotanasteroids")
    self:addTemplate("sectors/xsotantransformed")
    self:addTemplate("sectors/xsotanbreeders")
    self:addTemplate("sectors/resistancecell")

    self:addTemplate("sectors/teleporter")
end

function SectorSpecifics.determineFastContent(x, y, serverSeed)
    local regular = false
    local offgrid = false
    local dust = 0

    local hash1 = makeFastHash(x, y, serverSeed.int32);
    local hash2 = makeFastHash(x * 941083987 + 15485863, y * 961748927 + 492876847, serverSeed.int32);
    local hash3 = makeFastHash(x * 961748941 + 49979687, y * 982451653 + 553105243, serverSeed.int32);

    -- determine if there is regular content in the sector or undetectable content
    if hash1 % 100 <= 4 then -- 4% chance for regular content
        regular = true
    else
        regular = false
    end

    if not regular then
        if hash2 % 100 <= 5 then -- 5% chance for offgrid content
            offgrid = true
        else
            offgrid = false
        end
    end

    -- determine dustyness of the sector
    local d0 = 16
    local d1 = 6
    local d2 = 3
    local d3 = 1

    local num = hash3 % (d0 + d1 + d2 + d3)
    if num < d0 then
        dust = 0
    elseif num < d0 + d1 then
        dust = 1
    elseif num < d0 + d1 + d2 then
        dust = 2
    elseif num < d0 + d1 + d2 + d3 then
        dust = 3
    end

    return regular, offgrid, dust
end

function SectorSpecifics:determineContent(x, y, serverSeed)

    local regular, offgrid, dust = SectorSpecifics.determineFastContent(x, y, serverSeed)

    local blocked = false
    local home = false

    -- check if it's blocked, if yes, don't create any content
    if self.passageMap == nil or self.passageMap.seed ~= serverSeed then
        self.passageMap = PassageMap(serverSeed)
    end

    if not self.passageMap:passable(x, y) then
        blocked = true
        regular = false
        offgrid = false
        return regular, offgrid, blocked, home, dust
    else
        blocked = false
    end

    -- check if the sector is the home sector of a faction
    if self.factionsMap == nil or self.factionsMap.seed ~= serverSeed then
        self.factionsMap = FactionsMap(serverSeed)
    end

    local factionIndex = self.factionsMap:getFaction(x, y)

    if factionIndex == nil then
        if regular then
            offgrid = true
            regular = false
        end
    else
        local homeCoords = self.factionsMap:getHomeSector(factionIndex)

        if homeCoords.x == x and homeCoords.y == y then
            home = true
        end
    end

    -- if the sector has content ...
    if home then
        regular = true
        offgrid = false
    end

    return regular, offgrid, blocked, home, dust
end

function SectorSpecifics:initialize(x, y, serverSeed)

    -- sector seed is only actually used if the sector has content
    self.sectorSeed = getSectorSeed(x, y)
    self.coordinates = {x = x, y = y}
    self.generationTemplate = nil
    self.generationSeed = nil
    self.offgrid = false
    self.regular = false
    self.blocked = false
    self.gates = false
    self.ancientGates = false
    self.dustyness = 0
    self.name = x .. " : " .. y

    local home = false
    self.regular, self.offgrid, self.blocked, home, self.dustyness = self:determineContent(x, y, serverSeed)

    -- skip the rest if there is nothing in the sector to save performance
    if not self.offgrid and not self.regular then
        return
    end

    self:addTemplates()

    local rand = Random(self.sectorSeed)

    self.generationSeed = rand:createSeed()

    -- if the sector has content ...
    if home then
        self.generationTemplate = self.templates[1]

        self.name = SectorNameGenerator.generateSectorName(x, y, 0, serverSeed) .. " Prime"

    elseif self.regular then

        -- determine the number of the sector in the grid
        local lx, ly, ux, uy = SectorNameGenerator.gridDimensions(x, y)
        local c = 1

        for oy = ly, uy - 1 do
            for ox = lx, ux - 1 do
                if ox == x and oy == y then goto continue end

                local regular = self:determineContent(ox, oy, serverSeed)
                if regular then c = c + 1 end
            end
        end

        ::continue::

        self.name = SectorNameGenerator.generateSectorName(x, y, c, serverSeed)

        -- ... determine templates that will be used to generate content in this sector
        local templatesByWeight = {}

        for i, template in pairs(self.templates) do

            if not template.offgrid() then
                local weight = template.getProbabilityWeight(x, y, serverSeed)
                templatesByWeight[i] = weight
            end
        end

        local i = selectByWeight(rand, templatesByWeight)
        self.generationTemplate = self.templates[i]

        if self.generationTemplate.gates then
            self.gates = self.generationTemplate.gates(x, y, serverSeed)
        end

    elseif self.offgrid then

        local templatesByWeight = {}

        for i, template in pairs(self.templates) do

            if template.offgrid() then
                local weight = template.getProbabilityWeight(x, y, serverSeed)
                templatesByWeight[i] = weight
            end
        end

        local i = selectByWeight(rand, templatesByWeight)
        self.generationTemplate = self.templates[i]

        --Begin Added by RegenerativeAsteroids - Dirtyredz
        if self.generationTemplate['CustomName'] ~= nil then
          self.name = self.generationTemplate.CustomName
        end
        --End Added by RegenerativeAsteroids - Dirtyredz

    end

    if self.generationTemplate and self.generationTemplate.ancientGates then
        self.ancientGates = self.generationTemplate.ancientGates(x, y, serverSeed)
    end
end

function SectorSpecifics:getScript()
    if self.generationTemplate then
        return self.generationTemplate.path
    end

    return ""
end

function SectorSpecifics:generatePlanets()
    local seed = getSectorSeed(self.coordinates.x, self.coordinates.y + 2)

    local rand = Random(seed)
    local planets = {}

    if self.coordinates.x == 0 and self.coordinates.y == 0 then
        table.insert(planets, 1, SectorSpecifics.generateBlackHole(rand))
    else
        if rand:test(0.6) then
            table.insert(planets, 1, SectorSpecifics.generatePlanet(planets, rand))
        end
    end

    return unpack(planets)
end

function SectorSpecifics.getPlanetPosition(random, size)
    local minDist = (size / 2 + size / 5)
    local maxDist = size * 2

    return random:getDirection() * random:getFloat(minDist, maxDist)
end

function SectorSpecifics.generatePlanet(planets, random)
    local planet = PlanetSpecifics()

    planet.type = random:getInt(0, PlanetType.NumPlanetTypes - 1)
    while planet.type == PlanetType.BlackHole do
        planet.type = random:getInt(0, PlanetType.NumPlanetTypes - 1)
    end

    local moon = false

    if planet.type == PlanetType.Terrestrial then
        planet.atmosphere = true
        planet.clouds = true
        moon = random:getBool()
        planet.habitated = random:getBool()
        planet.ring = random:getBool()
        planet.size = random:getFloat(10, 14)

    elseif planet.type == PlanetType.Rocky then
        planet.atmosphere = random:getBool()
        planet.clouds = random:getBool()
        planet.habitated = random:getBool()
        moon = random:getBool()
        planet.ring = random:getBool()
        planet.size = random:getFloat(2, 10)

    elseif planet.type == PlanetType.GasGiant then
        planet.atmosphere = true
        planet.clouds = false
        planet.habitated = false
        moon = random:getBool()
        planet.ring = random:getBool()
        planet.size = random:getFloat(50, 140)

    elseif planet.type == PlanetType.Smooth then
        planet.atmosphere = random:getBool()
        planet.clouds = random:getBool()
        planet.habitated = random:getBool()
        moon = random:getBool()
        planet.ring = random:getBool()
        planet.size = random:getFloat(2, 8)

    elseif planet.type == PlanetType.Moon then
        planet.atmosphere = false
        planet.clouds = false
        planet.habitated = random:getBool()
        planet.ring = false
        planet.size = random:getFloat(0.5, 4)

    elseif planet.type == PlanetType.Volcanic then
        planet.atmosphere = true
        planet.clouds = false
        planet.habitated = false
        moon = random:getBool()
        planet.ring = random:getBool()
        planet.size = random:getFloat(9, 15)

    elseif planet.type == PlanetType.BlackHole then
        planet.atmosphere = true
        planet.clouds = false
        planet.habitated = false
        moon = false
        planet.ring = false
        planet.size = random:getFloat(0.5, 2)
    end

    planet.position = SectorSpecifics.getPlanetPosition(random, planet.size)

    local types = {}
    table.insert(types, 0)
    if moon then table.insert(types, 1) end
    if planet.ring then table.insert(types, 2) end

    local orbitType = types[random:getInt(1, #types)]

    if orbitType == 1 then -- moons
        planet.ring = false
        local moonSpecs = SectorSpecifics.generateMoon(random)

        -- position the moon
        local dir = normalize(moonSpecs.position)
        moonSpecs.position = planet.position + dir * (planet.size + moonSpecs.size) * 1.25

        -- if the camera would be inside the moon, move the moon away from the camera
        if length(moonSpecs.position) < (moonSpecs.size / 2) + (moonSpecs.size / 5) then
            -- moon is too near, move it away from the camera
            moonSpecs.position = moonSpecs.position + dir * (moonSpecs.size / 2)
        end

        table.insert(planets, moonSpecs)

    elseif orbitType == 2 then -- asteroid ring
        planet.ring = true
    elseif orbitType == 0 then -- no orbit
        planet.ring = false
    end

    return planet
end

function SectorSpecifics.generateMoon(random)
    local moon = PlanetSpecifics()

    local moonType = random:getInt(0, MoonType.NumMoonTypes - 1)
    moon.size = random:getFloat(2, 8)

    if moonType == MoonType.Rocky then
        moon.atmosphere = random:getBool()
        moon.clouds = random:getBool()
        moon.habitated = random:getBool()

        moon.type = PlanetType.Rocky

    elseif moonType == MoonType.Smooth then
        moon.atmosphere = random:getBool()
        moon.clouds = random:getBool()
        moon.habitated = random:getBool()

        moon.type = PlanetType.Smooth

    elseif moonType == MoonType.Moon then
        moon.atmosphere = false
        moon.clouds = false
        moon.habitated = random:getBool()

        moon.type = PlanetType.Moon

    elseif moonType == MoonType.Volcanic then
        moon.atmosphere = true
        moon.clouds = false
        moon.habitated = false

        moon.type = PlanetType.Volcanic
    end

    moon.position = SectorSpecifics.getPlanetPosition(random, moon.size);

    return moon
end

function SectorSpecifics.generateBlackHole(random)
    local hole = PlanetSpecifics()

    hole.type = PlanetType.BlackHole

    hole.atmosphere = true
    hole.clouds = false
    hole.habitated = false
    hole.ring = true
    hole.size = random:getFloat(0.5, 2)
    hole.position = SectorSpecifics.getPlanetPosition(random, hole.size)

    return hole
end

function SectorSpecifics.getShuffledCoordinates(random, cx, cy, dmin, dmax)
    local coords = {}

    local dmin2 = dmin * dmin
    local dmax2 = dmax * dmax

    local minBounds = Balancing_GetMinCoordinates()
    local maxBounds = Balancing_GetMaxCoordinates()

    local lx = math.max(minBounds, cx - dmax)
    local ux = math.min(maxBounds, cx + dmax)

    local ly = math.max(minBounds, cy - dmax)
    local uy = math.min(maxBounds, cy + dmax)

    for y = ly, uy do
        for x = lx, ux do
            local dx = cx - x
            local dy = cy - y
            local d2 = dx * dx + dy * dy

            if d2 >= dmin2 and d2 <= dmax2 then
                table.insert(coords, {x = x, y = y})
            end
        end
    end

    shuffle(random, coords)

    return coords
end

function SectorSpecifics:findFreeSector(random, cx, cy, dmin, dmax, serverSeed)

    local coords = self.getShuffledCoordinates(random, cx, cy, dmin, dmax)

    for _, coord in pairs(coords) do
        local regular, offgrid, blocked, home = self:determineContent(coord.x, coord.y, serverSeed)

        if not regular and not offgrid and not blocked and not home then
            return coord
        end
    end

    print ("Error: No free sector found at %i:%i, min: %d, max: %d", cx, cy, dmin, dmax)

end

function SectorSpecifics:findRegularSector(random, cx, cy, dmin, dmax, serverSeed, script)

    local coords = self.getShuffledCoordinates(random, cx, cy, dmin, dmax)

    for _, coord in pairs(coords) do
        local regular = self:determineContent(coord.x, coord.y, serverSeed)

        if regular then
            -- when a script is specified, test for the script
            if script then
                local specs = SectorSpecifics(coord.x, coord.y, serverSeed)
                if specs.generationTemplate and string.match(specs.generationTemplate.path, script) then
                    return coord
                end
            else
                return coord
            end
        end
    end

    print ("Error: No regular sector found at %i:%i, min: %d, max: %d, script: %s", cx, cy, dmin, dmax, script or "")

end

function SectorSpecifics:findOffgridSector(random, cx, cy, dmin, dmax, serverSeed, script)

    local coords = self.getShuffledCoordinates(random, cx, cy, dmin, dmax)

    for _, coord in pairs(coords) do
        local regular, offgrid = self:determineContent(coord.x, coord.y, serverSeed)

        if offgrid then
            -- when a script is specified, test for the script
            if script then
                local specs = SectorSpecifics(coord.x, coord.y, serverSeed)
                if specs.generationTemplate and string.match(specs.generationTemplate.path, script) then
                    return coord
                end
            else
                return coord
            end
        end
    end

    print ("Error: No offgrid sector found at %i:%i, min: %d, max: %d, script: %s", cx, cy, dmin, dmax, script or "")

end

function SectorSpecifics:findSector(random, cx, cy, dmin, dmax, serverSeed, script)

    local coords = self.getShuffledCoordinates(random, cx, cy, dmin, dmax)

    for _, coord in pairs(coords) do
        local regular, offgrid = self:determineContent(coord.x, coord.y, serverSeed)

        if regular or offgrid then
            -- when a script is specified, test for the script
            if script then
                local specs = SectorSpecifics(coord.x, coord.y, serverSeed)
                if specs.generationTemplate and string.match(specs.generationTemplate.path, script) then
                    return coord
                end
            else
                return coord
            end
        end
    end

    print ("Error: No sector found at %i:%i, min: %d, max: %d, script: %s", cx, cy, dmin, dmax, script or "")

end

-- returns all regular sector templates that will have stations
function SectorSpecifics.getRegularStationSectors()
    local destinations = {}

    destinations["sectors/colony"] = true
    destinations["sectors/loneconsumer"] = true
    destinations["sectors/loneshipyard"] = true
    destinations["sectors/lonetrader"] = true
    destinations["sectors/lonetradingpost"] = true
    destinations["sectors/factoryfield"] = true
    destinations["sectors/basefactories"] = true
    destinations["sectors/lowfactories"] = true
    destinations["sectors/midfactories"] = true
    destinations["sectors/highfactories"] = true
    destinations["sectors/miningfield"] = true
    destinations["sectors/neutralzone"] = true

    return destinations
end

return setmetatable({new = new}, {__call = function(_, ...) return new(...) end})
