Turret = require "Data/Scripts/TurretFuncs"
-- turrets is a table of all of the different turrets in the level
turrets = {}

function onGameBuild()
  -- these will be laser turrets 
  turrets[0] = {}
  turrets[0]["eid"] = Turret.generate(7, 3.5, 8, 0, 0, 1.57)
  turrets[0]["timer"] = 0
  turrets[0]["shootRate"] = .2
  turrets[0]["force"] = 1000

  turrets[1] = {}
  turrets[1]["eid"] = Turret.generate(4, 6, 1, 0, 3.14, 2.57)
  turrets[1]["timer"] = 0
  turrets[1]["shootRate"] = .2
  turrets[1]["force"] = 1000

  turrets[2] = {}
  turrets[2]["eid"] = Turret.generate(-7, -1, -9, 0, 3.14, -1.57)
  turrets[2]["timer"] = 0
  turrets[2]["shootRate"] = .2
  turrets[2]["force"] = 1000


  -- these three turrets are grouped together on the second ring, creating a timing challenge
  turrets[3] = {}
  turrets[3]["eid"] = Turret.generate(5, 4, -9.6, 0, 1.40, 2.75)
  turrets[3]["timer"] = 0
  turrets[3]["shootRate"] = 4
  turrets[3]["force"] = 250

 
  turrets[4] = {}
  turrets[4]["eid"] = Turret.generate(5, 4, -10.6, 0, 1.40, 2.75)
  turrets[4]["timer"] = 1.5
  turrets[4]["shootRate"] = 4
  turrets[4]["force"] = 250

  
  turrets[5] = {}
  turrets[5]["eid"] = Turret.generate(5, 4, -11.6, 0, 1.40, 2.75)
  turrets[5]["timer"] = 2.5
  turrets[5]["shootRate"] = 4
  turrets[5]["force"] = 250

end

function onGameUpdate (dt)
  -- Turret.updateTurrets fires turrets based on their shootRate, force, etc
  Turret.updateTurrets(turrets, dt)
  playerPosCID = ECS.getComponentID("Position", State.getPlayer())
  x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%i, %i, %i", x, y, z))
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)