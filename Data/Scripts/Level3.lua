function onGameBuild()
  eIDBase, eIDTurret = makeTurret(-6, -5, 3)
end

function onGameUpdate (dt)
	pEID = State.getPlayer()
	playerPosCID = ECS.getComponentID("Position", pEID)
	x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%i, %i, %i", x, y, z))
end

function makeTurret(x, y, z)
  eIDBase = ECS.Templates.TurretBase()
  cIDPhys = ECS.getComponentID("BulletObject", eIDBase)
  ECS.BulletObject.createBody(cIDPhys)
  cIDPos = ECS.getComponentID("Position", eIDBase)
  ECS.BulletObject.setPosition(cIDPhys, x, y, z)
  
  eIDTurret = ECS.Templates.Turret()
  cIDPhysTurret = ECS.getComponentID("BulletObject", eIDTurret)
  ECS.BulletObject.createBody(cIDPhysTurret)
  
  ECS.BulletObject.Constraint.addFixed(cIDPhysTurret, "TurretSwivel", cIDPhys, 0, 0.7, 0)
  
  return eIDBase, eIDTurret
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)