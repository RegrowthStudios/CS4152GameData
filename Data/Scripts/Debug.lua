function debugAddForce (eID, dt)
  local cID = ECS_getComponentID("BulletObject", eID)
  print("Check ID")
  print(cID)
  if cID ~= 0 then
    print("Apply force")
    BulletObject_applyForce(gameState, cID, 0, 1000, 0)
  end
end

Vorb.register("debugAddForce", debugAddForce)
