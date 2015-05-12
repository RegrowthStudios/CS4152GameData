local Debug = {}

function Debug.setInfo(lineOne, lineTwo, lineThree, lineFour, lineFive)
  Client.setDebugInfo(lineOne, lineTwo, lineThree, lineFour, lineFive)
end

function Debug.show(currentRing)
  pEID = State.getPlayer()
  playerPosCID = ECS.getComponentID("Position", pEID)
  playerBulletCID = ECS.getComponentID("BulletObject", pEID)
  x, y, z = ECS.Position.getPosition(playerPosCID)
  qx, qy, qz, qw = ECS.Position.getQuaternion(playerPosCID)
  fx, fy, fz = ECS.Position.getForward(playerPosCID)
  posStr = string.format("%g, %g, %g", x, y, z)
  quatStr = string.format("%.3f, %.3f, %.3f, %.3f", qx, qy, qz, qw)
  ringStr = string.format("Current Ring: %d", currentRing)
  forwardStr = string.format("%g, %g, %g", fx, fy, fz)
  lineFive = "Happy Debugging!"
  Client.setDebugInfo(posStr, quatStr, ringStr, forwardStr, lineFive)
end

function Debug.potato()
  Client.Renderer.SSAO.setActive(false)
  Client.Renderer.DoF.setActive(false)
  Client.Renderer.MotionBlur.setActive(false)
  Client.Renderer.Bloom.setActive(false)
end


return Debug