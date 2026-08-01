-- JWeezy Construction Category & Tab Loader
JWeezyCategoryLoader = {}
local isLoaded = false

function JWeezyCategoryLoader:initCategories()
    -- Prevent duplicate runs
    if isLoaded then return end

    if g_storeManager ~= nil then
        local iconAtlas = "$dataS/menu/construction/ui_construction_icons.dds"
        local uvCategory = GuiUtils.getUVs("80px 40px 32px 32px", string.getVectorN("256 256", 2))

        -- 1. Create the JWEEZY Category
        g_storeManager:addConstructionCategory("JWEEZY", "JWeezy Construction", iconAtlas, uvCategory, "")

        -- 2. Create the Sub-Tabs under JWEEZY (Preserving exact requested case)
        g_storeManager:addConstructionTab("JWEEZY", "trackStraight",  "Straight Tracks", iconAtlas, GuiUtils.getUVs("80px 40px 32px 32px", string.getVectorN("256 256", 2)), "")
        g_storeManager:addConstructionTab("JWEEZY", "trackCurve",     "Curved Tracks",   iconAtlas, GuiUtils.getUVs("80px 40px 32px 32px", string.getVectorN("256 256", 2)), "")
        g_storeManager:addConstructionTab("JWEEZY", "trackMisc",      "Misc Tracks",     iconAtlas, GuiUtils.getUVs("80px 40px 32px 32px", string.getVectorN("256 256", 2)), "")
        g_storeManager:addConstructionTab("JWEEZY", "railroadExtras", "Railroad Extras", iconAtlas, GuiUtils.getUVs("40px 0px 32px 32px", string.getVectorN("256 256", 2)), "")
        g_storeManager:addConstructionTab("JWEEZY", "trenches",       "Trenches",        iconAtlas, GuiUtils.getUVs("40px 160px 32px 32px", string.getVectorN("256 256", 2)), "")
        g_storeManager:addConstructionTab("JWEEZY", "pipe",           "Pipes",           iconAtlas, GuiUtils.getUVs("40px 160px 32px 32px", string.getVectorN("256 256", 2)), "")

        -- 3. SAFE REORDER: Assign sort orders without destroying category lookup tables
        local categories = g_storeManager.constructionCategories
        if categories ~= nil then
            for idx, cat in ipairs(categories) do
                if cat.name == "JWEEZY" then
                    cat.order = 999 -- Assign high order so it sorts last
                else
                    cat.order = cat.order or idx -- Retain default sort order
                end
            end

            -- Sort array safely using order key
            table.sort(categories, function(a, b)
                return (a.order or 0) < (b.order or 0)
            end)
        end -- Closed the 'if categories ~= nil' block
        
        print("--> [JWeezy Mod]: Construction categories and tabs loaded!")
        isLoaded = true
    end
end

StoreManager.loadMapData = Utils.appendedFunction(StoreManager.loadMapData, function(...)
    JWeezyCategoryLoader:initCategories()
end)


--[[ Indexed Icons (ones i could find, which are the ones we can see as of now)
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

+MAIN BUILDINGS ("0 0
----------------------------------
-Sheds ("40px 0
-Silos ("80px 0
-Silo Extensions ("200px 0
-Container ("120px 0
-Tools ("160px 0
-Farmhouses ("40px 120px

+MAIN PRODUCTION ("0 40px
----------------------------------
-Factories ("40px 40px
-Selling Points ("80px 40px
-Greenhouses ("120px 40px
-Orchards ("200px 40px
-Generators ("160px 40px

+ANIMALS ("0 80px
----------------------------------
-Cows ("0 80px
-Horses ("120px 80px
-Pigs ("40px 80px
-Sheep ("80px 80px
-Chickens ("160px 120px
-Bees ("160px 80px
-Others(paws) ("200px 80px

+DECORATION ("0 120px
----------------------------------
-Fences ("80px 120px
-Lights ("120px 120px
-Others ("40px 120px

+LANDSCAPING ("0 160px
----------------------------------
-Sculpting ("40px 160px
-Painting ("80px 160px
-Trees ("120px 160px
-Plants ("160px 160px
--]]

--[[ Those indexes took longer than needed to find.
Shout me out if this helps you. If you need help, 
Echelon#2382 on Discord --]]