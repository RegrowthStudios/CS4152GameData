turret1 = 0
turret2 = 0
turret3 = 0
t = 0

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
  t = t + dt
  if t > 1 then
    shootFromEntity(turret1)
    shootFromEntity(turret2)
    shootFromEntity(turret3)
    t = 0    
  end
  Client.setMessage(string.format("%i, %i, %i", x, y, z))
end

function makeTurret(x, y, z)
  eIDTurret = ECS.Templates.Turret()
  cIDPhysTurret = ECS.getComponentID("BulletObject", eIDTurret)
  ECS.BulletObject.createBody(cIDPhysTurret)
  ECS.BulletObject.setPosition(cIDPhysTurret, x, y, z)
  
  return eIDTurret
end

function shootFromEntity(eIDTurret)
  -- Get player info
  cID = ECS.getComponentID("Position", eIDTurret)
  x,y,z = ECS.Position.getPosition(cID)
  fx,fy,fz = ECS.Position.getForward(cID)
  
  -- Spawn ball
  eID = ECS.Templates.Projectile()
  cIDPos = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cIDPos, x, y, z) 

  -- Shoot ball
  cIDPhys = ECS.getComponentID("BulletObject", eID)
  ECS.BulletObject.createBody(cIDPhys)
  ECS.BulletObject.applyForce(cIDPhys, fx * 300, fy * 300, fz * 300)
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)