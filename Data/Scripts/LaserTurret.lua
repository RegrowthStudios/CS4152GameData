LaserTurretProps = {
  offsetForward = 0.5,
  offsetUp = 0.0
}

Vorb.register("Update.LaserTurret", function (eID, dt)
  -- Find position and basis directions of turret
  local cIDPos = ECS.getComponentID("Position", eID)
  local cIDBullet = ECS.getComponentID("BulletObject", eID)

  -- align forward or backwards
  local ex, ey, ez = ECS.Position.getOrientation(cIDPos)
  if ex < 1.52 and ex > -1.52 then 
  -- todo?  check if abs(ex-0), abs(ey-3.14) etc is too big?
  -- snap towards forwards
    ECS.Position.setOrientation(cIDPos, 0.0, 0.0, ez)

  else 
  -- snap towards backwards
    ECS.Position.setOrientation(cIDPos, -math.pi, 0, ez)
  end 

  local px, py, pz = ECS.Position.getPosition(cIDPos)
  local fx, fy, fz = ECS.Position.getForward(cIDPos)
  local ux, uy, uz = ECS.Position.getUp(cIDPos)
  
  local oF = LaserTurretProps.offsetForward
  local oU = LaserTurretProps.offsetUp
  px = px + (oF * fx) + (oU * ux)
  py = py + (oF * fy) + (oU * uy)
  pz = pz + (oF * fz) + (oU * uz)
  local rayDistance = Game.raycastFromPosition(px,py,pz, fx,fy,fz, 1000)
  
  if (rayDistance < 0) then
    Client.Renderer.drawLaser(px,py,pz, fx,fy,fz, 1000, 0.05)
  else
    Client.Renderer.drawLaser(px,py,pz, fx,fy,fz, rayDistance, 0.05)
  end
end)
