Debug = require "Data/Scripts/DebugFuncs"


messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched4"] = false
flags["touched6"] = false
flags["touched7"] = false
flags["touched8"] = false
flags["touched9"] = false
currentRing = 0

function onGameBuild()
  Debug.potato()

  -- Make end portal
  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 8.0, -43.0)
  ECS.Position.setQuaternion(cID, 1.0, 0.0, 0.0, 0.0)


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -9.2, -10.3, -22.0)
  ECS.Position.setQuaternion(cID, -0.44, -0.127, -0.26, 0.96)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -9.2, -10.3, -23.5)
  ECS.Position.setQuaternion(cID, -0.44, -0.127, -0.26, 0.96)


  -- Make fixed ring
  bCID = ECS.getComponentID("BulletObject", 11)
  ECS.BulletObject.setMass(bCID, 0)

  rrfCID = ECS.getComponentID("RingRotationFactor", 6)
  ECS.RingRotationFactor.set(rrfCID, 0.5)

  rrfCID = ECS.getComponentID("RingRotationFactor", 9)
  ECS.RingRotationFactor.set(rrfCID, 5.0)
  
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
  if id == 9 and not flags["touched9"] then
    table.insert(messageQueue, createMessage("Narrative0", "If you roll over the YELLOW JUMPPAD,"))
    table.insert(messageQueue, createMessage("Narrative1", "you'll get a break from solving puzzles."))
    flags["touched9"] = true 
  end
  if id == 6 and not flags["touched6"] then
    table.insert(messageQueue, createMessage("Narrative2", "You can push around GREY RINGS with GREEN RINGS."))
    flags["touched6"] = true
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