function updateTurret(eID, dt)

  cIDPos = ECS.getComponentID("Position", eID)
  ux, uy, uz = ECS.Position.getUp(cIDPos)
  print(string.format("%f,%f,%f", ux, uy, uz))
  
  cIDPhys = ECS.getComponentID("BulletObject", eID)
  -- ECS.BulletObject.torque(cIDPhys, 0, 16, 0)
  print(string.format("%d: %d,%d", eID, cIDPos, cIDPhys))
end

  

Vorb.register("Update.Turret", updateTurret)
