Debug = require "Data/Scripts/DebugFuncs"


messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched5"] = false
flags["touched8"] = false
flags["touched7"] = false
flags["touched9"] = false
flags["touched4"] = false
flags["touched6"] = false
flags["touched7"] = false
currentRing = 0

function onGameBuild()
  --Client.Renderer.setMode("Low")
  -- Create End Portal
  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.5, 11.26, -53.0)
  ECS.Position.setQuaternion(cID, 0.73, -0.06, -0.67, -0.05)

  -- Make rings rotatable by player
  rrfCID = ECS.getComponentID("RingRotationFactor", 4)
  ECS.RingRotationFactor.set(rrfCID, 1.5)

  rrfCID = ECS.getComponentID("RingRotationFactor", 6)
  ECS.RingRotationFactor.set(rrfCID, 1.5)

  -- make fixed ring
  bCID = ECS.getComponentID("BulletObject", 10)
  ECS.BulletObject.setMass(bCID, 0)

  -- decorative meshes

  eID = ECS.Templates.PaintingPillar()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -7.5, 0, 10.0)
  ECS.Position.setQuaternion(cID, 0.55, 0.55, 0.443, -0.43)
end

function onGameUpdate (dt)
  Debug.show(currentRing)
  messageTime = messageTime + dt
  if messageTime > 6.0 then
    Client.hideHUD()
  end
  if messageTime > 6.0 then
    if tablelength(messageQueue) > 0 then
      message = table.remove(messageQueue, 1)
      Client.setMessage(message.message)
      -- Client.Sound.play2D(message.fx, 1.0)
      messageTime = 0.0 
    end
  end
end

function createMessage(narration, strMessage)
  msg = {}
  msg["fx"] = narration
  msg["message"] = strMessage
  return msg
end

function onRingContact(id)
  currentRing = id
  if id == 5 and not flags["touched5"] then
    table.insert(messageQueue, createMessage("Narrative1", "Use WASD to roll, and the MOUSE to look around."))
    flags["touched5"] = true 
  end
  if id == 8 and not flags["touched8"] then
    table.insert(messageQueue, createMessage("Narrative3", "Use SPACEBAR to jump."))
    flags["touched8"] = true
  end
  if id == 9 and not flags["touched9"] then
    table.insert(messageQueue, createMessage("Narrative4", "You can roll up walls by pressing SPACEBAR repeatedly."))
    flags["touched9"] = true
  end
  if id == 4 and not flags["touched4"] then
    table.insert(messageQueue, createMessage("Narrative6", "You can rotate GREEN RINGS with Q and E."))
    flags["touched4"] = true
  end
  if id == 6 and not flags["touched6"] then
    table.insert(messageQueue, createMessage("Narrative7", "GREEN RINGS are blocked by BLACK RINGS."))
    flags["touched6"] = true
  end
  if id == 7 and not flags["touched7"] then
    table.insert(messageQueue, createMessage("Narrative7", "Throw yourself into the BLUE FLAMES."))
    flags["touched7"] = true
  end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)