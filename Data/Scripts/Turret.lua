turretForcePower = 1000.0

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

function updateTurret(eID, dt)
  cIDPos = ECS.getComponentID("Position", eID)
  ux, uy, uz = ECS.Position.getUp(cIDPos)
  print(string.format("%f,%f,%f", ux, uy, uz))
  
  cIDPhys = ECS.getComponentID("BulletObject", eID)
  -- ECS.BulletObject.torque(cIDPhys, 0, 16, 0)
  print(string.format("%d: %d,%d", eID, cIDPos, cIDPhys))
end

Vorb.register("Update.Turret", updateTurret)
