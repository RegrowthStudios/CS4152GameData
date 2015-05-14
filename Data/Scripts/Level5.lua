Debug = require "Data/Scripts/DebugFuncs"
Turret = require "Data/Scripts/TurretFuncs"
-- turrets is a table of all of the different turrets in the level
turrets = {}
messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched4"] = false
flags["touched6"] = false
flags["touched7"] = false
flags["touched8"] = false
flags["touched12"] = false
currentRing = 0
time = 0.0
FIRST_GREEN = 5
FIRST_BLACK = 6
SECOND_GREEN = 7
FIRST_RED = 9





function onGameBuild()
  --Client.Renderer.setMode("Low")

  -- tutorial turrets on first ring, firing into blades


  eID = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 7.5, 8)
  ECS.Position.setQuaternion(cID, -0.6, 0.0, 0.737, 0.0)

  eID = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 7.5, 10)
  ECS.Position.setQuaternion(cID, -0.6, 0.0, 0.737, 0.0)

  eID = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 7.5, 12)
  ECS.Position.setQuaternion(cID, -0.6, 0.0, 0.737, 0.0)



--[[

  turrets[3] = {}
  turrets[3]["eid"] = 8
  turrets[3]["type"] = "projectile"
  turrets[3]["timer"] = 0
  turrets[3]["shootRate"] = 4
  turrets[3]["force"] = 250

 
  turrets[4] = {}
  turrets[4]["eid"] = 9
  turrets[4]["type"] = "projectile"
  turrets[4]["timer"] = 1.5
  turrets[4]["shootRate"] = 4
  turrets[4]["force"] = 250

  
  turrets[5] = {}
  turrets[5]["eid"] = 10
  turrets[5]["type"] = "projectile"
  turrets[5]["timer"] = 2.5
  turrets[5]["shootRate"] = 4
  turrets[5]["force"] = 250
]]
  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)

  bCID = ECS.getComponentID("BulletObject", FIRST_RED)
  ECS.BulletObject.applyTorque(bCID, 0, 0, 3000)

  --Turret.updateTurrets(turrets, dt)
  playerPosCID = ECS.getComponentID("Position", State.getPlayer())
  x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%i, %i, %i", x, y, z))

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