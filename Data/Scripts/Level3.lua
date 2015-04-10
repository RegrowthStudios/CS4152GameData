Turrets = require "Data/Scripts/TurretFuncs"
turrets = {}
t = 0

function onGameBuild()
  turrets[1] = Turrets.makeTurret(7, 3.5, 8) 
  turrets[2] = Turrets.makeTurret(4, 6, 1) 
  turrets[3] = Turrets.makeTurret(0, -8, 18) 
  cID = ECS.getComponentID("BulletObject", turrets[1])
  ECS.BulletObject.setOrientation(cID, 0, 0, 1.57) 
  cID = ECS.getComponentID("BulletObject", turrets[2])
  ECS.BulletObject.setOrientation(cID, 0, 3.14, 2.57) 
  cID = ECS.getComponentID("BulletObject", turrets[3])
  ECS.BulletObject.setOrientation(cID, 0, 0, 0) 
end

function onGameUpdate (dt)
  t = t + dt
  if t > .2 then
    Turrets.shootFromTurret(turrets[1])
    Turrets.shootFromTurret(turrets[2])
    Turrets.shootFromTurret(turrets[3])
    t = 0    
  end
  playerPosCID = ECS.getComponentID("Position", State.getPlayer())
  x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%i, %i, %i", x, y, z))
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)