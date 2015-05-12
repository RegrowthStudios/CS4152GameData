Debug = require "Data/Scripts/DebugFuncs"


messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched4"] = false
flags["touched6"] = false
flags["touched7"] = false
flags["touched8"] = false
flags["touched12"] = false
currentRing = 0

function onGameBuild()
    Client.Renderer.SSAO.setActive(false)
  Client.Renderer.DoF.setActive(false)
  -- Create End Portal
  --[[
  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.5, 11.26, -46.0)
  ECS.Position.setQuaternion(cID, 0.73, -0.06, -0.67, -0.05)
  ]]
  -- Make rings rotatable by player

  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 8.0, -40.0)
  ECS.Position.setQuaternion(cID, 0.005, -0.306, 0.014, 0.952)


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -10.0, 5.8, -23)
  ECS.Position.setQuaternion(cID, 0.6, 0.36, 0.59, -0.35)


  -- Make fixed ring
  bCID = ECS.getComponentID("BulletObject", 11)
  ECS.BulletObject.setMass(bCID, 0)

  rrfCID = ECS.getComponentID("RingRotationFactor", 6)
  ECS.RingRotationFactor.set(rrfCID, 0.5)

  rrfCID = ECS.getComponentID("RingRotationFactor", 9)
  ECS.RingRotationFactor.set(rrfCID, 3.0)
  print("onbuild")
  
  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)

  Debug.show(currentRing)
  messageTime = messageTime + dt
  if messageTime > 5.0 then
    Client.setMessage(" ")
  end
  if messageTime > 5.5 then
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
  if id == 3 and not flags["touched3"] then
    table.insert(messageQueue, createMessage("Narrative0", "I recently erased your memory,"))
    table.insert(messageQueue, createMessage("Narrative1", "so you might feel a bit confused about your environment."))
    flags["touched3"] = true 
  end
  if id == 5 and not flags["touched5"] then
    table.insert(messageQueue, createMessage("Narrative2", "Oh, so you left that first ring?  Neat."))
    table.insert(messageQueue, createMessage("Narrative3", "Spacebar to jump."))
    flags["touched5"] = true
  end
  if id == 6 and not flags["touched6"] then
    table.insert(messageQueue, createMessage("Narrative4", "You're on the Array,"))
    table.insert(messageQueue, createMessage("Narrative5", "the last record of humanity in the universe."))
    flags["touched6"] = true
  end
  if id == 7 and not flags["touched7"] then
    table.insert(messageQueue, createMessage("Narrative6", "You can rotate green rings like this one with Q and E."))
    flags["touched7"] = true
  end
  if id == 11 and not flags["touched11"] then
    table.insert(messageQueue, createMessage("Narrative7", "Don't go near that glowing portal thing..."))
    flags["touched11"] = true
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