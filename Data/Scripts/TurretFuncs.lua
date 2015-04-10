local Turret = {}

function Turret.generate(x, y, z)
  eIDTurret = ECS.Templates.Turret()
  cIDPhysTurret = ECS.getComponentID("BulletObject", eIDTurret)
  ECS.BulletObject.createBody(cIDPhysTurret)
  ECS.BulletObject.setPosition(cIDPhysTurret, x, y, z)
  
  return eIDTurret
end

function Turret.shootFromTurret(eIDTurret, force)
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
  ECS.BulletObject.applyForce(cIDPhys, fx * force, fy * force, fz * force)
end

return Turret