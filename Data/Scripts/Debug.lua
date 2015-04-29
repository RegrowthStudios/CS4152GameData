function debugAddForce (eID, dt)
  local cID = ECS.getComponentID("BulletObject", eID)
  print("Check ID")
  print(cID)
  if cID ~= 0 then
    print("Apply force")
    -- ECS.BulletObject.applyForce(cID, 0, 1000, 0)
  end
end

Vorb.register("debugAddForce", debugAddForce)
