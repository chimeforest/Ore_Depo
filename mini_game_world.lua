
local Point3 = _radiant.csg.Point3

local MiniGame = class()

function MiniGame:start()
   -- create a tiny world
   microworld:create_world(128)

   local player_id = microworld:get_local_player_id()
   local pop = stonehearth.population:get_population(player_id)

   -- embark at 0, 0
   microworld:place_town_banner(0, 0)

   -- make sure the firepit is owned by the local player.  otherwise we'll
   -- run into trouble when people go to light it.
   microworld:place_entity('stonehearth:decoration:firepit', 0, 11, {
         owner = player_id,
         full_size = true,
      })

   -- add some bushes so our citizens don't starve
   for x = 1,4 do
      for z = 1,2 do
         microworld:place_entity('stonehearth:berry_bush', 4 + x * 4, 2 + z * 4)
      end
   end

   -- drop some trees, too
   for x = 1,2 do
      for z = 1,3 do
         microworld:place_entity('stonehearth:large_oak_tree', 0 + x * 15, 5 + z * 15)
      end
   end
   
   -- place some boulders.  those can be harvested, too!
   for x = 1,6 do
      for z = 1,2 do
         microworld:place_entity('stonehearth:large_boulder_1', 5 + x * 5, -15 + z * 5)
      end
   end
   
   -- place some ore deposits
   microworld:place_entity('ore_depo:coal_depo',  10, -20)
   microworld:place_entity('ore_depo:copper_depo',  15, -20)
   microworld:place_entity('ore_depo:gold_depo',  20, -20)
   microworld:place_entity('ore_depo:iron_depo',  25, -20)
   microworld:place_entity('ore_depo:silver_depo',  30, -20)
   microworld:place_entity('ore_depo:tin_depo',  35, -20)
   
   -- place silkweeds
   for x = 1,5 do
      for z = 1,3 do
         microworld:place_entity('stonehearth:plants:silkweed', 12 + x, 0 + z)
      end
   end
   
   --place talismans
   microworld:place_entity('stonehearth:blacksmith:talisman',  10, 10)
   microworld:place_entity('stonehearth:weaver:talisman',  10, 11)
   microworld:place_entity('stonehearth:mason:talisman',  10, 12)
   microworld:place_entity('stonehearth:farmer:talisman',  10, 13)
   microworld:place_entity('stonehearth:shepherd:talisman',  10, 14)
   microworld:place_entity('stonehearth:footman:wooden_sword_talisman',  10, 15)

   -- create a stockpile
   microworld:place_stockpile(-4, 13, 9, 9)
   
   -- and a cute little fox.
   microworld:place_entity('stonehearth:red_fox', 2, 2)

   -- create all the workers.
   local workers = {}
   for x = 1,3 do
      for z = 1,2 do
         local worker = microworld:place_citizen(-5 + (x * 3), -5 + (z * 3))
         table.insert(workers, worker)
      end
   end

   -- give some of the workers some starting items.
   local player_id = microworld:get_local_player_id()
   local pop = stonehearth.population:get_population(player_id)

   local function pickup(who, uri)
      local item = pop:create_entity(uri)
      radiant.entities.pickup_item(who, item)
   end
   pickup(workers[6], 'stonehearth:resources:wood:oak_log')
   pickup(workers[2], 'stonehearth:resources:fiber:silkweed_bundle')
   pickup(workers[3], 'stonehearth:trapper:talisman')
   pickup(workers[4], 'stonehearth:carpenter:talisman')
end

return MiniGame

