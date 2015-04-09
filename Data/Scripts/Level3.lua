turret1 = 0
turret2 = 0
turret3 = 0

function onGameBuild()
  eIDTurret = makeTurret(7, 3.5, 8) 
  turret1= eIDTurret
  eIDTurret = makeTurret(4, 6, 1) 
  turret2 = eIDTurret
  eIDTurret = makeTurret(0, -8, 18) 
  turret3 = eIDTurret
  cID = ECS.getComponentID("BulletObject", turret1)
  ECS.BulletObject.setOrientation(cID, 0, 0, 1.57) 
  cID = ECS.getComponentID("BulletObject", turret2)
  ECS.BulletObject.setOrientation(cID, 0, 3.14, 2.57) 
  cID = ECS.getComponentID("BulletObject", turret3)
  ECS.BulletObject.setOrientation(cID, 0, 0, 0) 
end

function onGameUpdate (dt)
	pEID = State.getPlayer()
	playerPosCID = ECS.getComponentID("Position", pEID)
	x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%i, %i, %i", x, y, z))



end

function makeTurret(x, y, z)
  eIDTurret = ECS.Templates.Turret()
  cIDPhysTurret = ECS.getComponentID("BulletObject", eIDTurret)
  ECS.BulletObject.createBody(cIDPhysTurret)
  ECS.BulletObject.setPosition(cIDPhysTurret, x, y, z)
  
  return eIDTurret
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)