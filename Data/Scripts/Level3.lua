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
  if t > .2 then
    shootFromTurret(turret1)
    shootFromTurret(turret2)
    shootFromTurret(turret3)
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

function shootFromTurret(eIDTurret)
  -- Get player info
  cID = ECS.getComponentID("Position", eIDTurret)
  x,y,z = ECS.Position.getPosition(cID)
  fx,fy,fz = ECS.Position.getForward(cID)
  ux,uy,uz = ECS.Position.getUp(cID)
  
  -- Spawn ball
  eID = ECS.Templates.Projectile()
  cIDPos = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cIDPos, x + (1.25 * fx) + (.35 * ux), y + (1.25  * fy) + (.35 * uy), z + (1.25  * fz) + (.35 * uz)) 

  -- Shoot ball
  cIDPhys = ECS.getComponentID("BulletObject", eID)
  ECS.BulletObject.createBody(cIDPhys)
  ECS.BulletObject.applyForce(cIDPhys, fx * 1000, fy * 1000, fz * 1000)
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)