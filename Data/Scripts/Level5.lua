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
FIRST_RED = 5
FIRST_BLACK = 6
SECOND_GREEN = 7
PROJ_1 = 0 
PROJ_2 = 0
PROJ_3 = 0





function onGameBuild()
  --Client.Renderer.setMode("Low")

  -- tutorial turrets on first ring, firing into blades


  PROJ_1 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_1)
  ECS.Position.setPosition(cID, 0.0, 7.5, 9)
  ECS.Position.setOrientation(cID, 0.0, math.pi/2, -2.8)

  PROJ_2 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_2)
  ECS.Position.setPosition(cID, 0.0, 7.5, 10)
  ECS.Position.setOrientation(cID, 0.0, math.pi/2, -2.8)

  PROJ_3 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_3)
  ECS.Position.setPosition(cID, 0.0, 7.5, 11.0)
  ECS.Position.setOrientation(cID, 0.0, math.pi/2, -2.8)

  PROJ_4 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_4)
  ECS.Position.setPosition(cID, 0.0, 7.5, 12)
  ECS.Position.setOrientation(cID, 0.0, math.pi/2, -2.8)

  eID = ECS.Templates.ForwardJumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.0, 7.3, 2.17)
  ECS.Position.setOrientation(cID, 0.0, -0.036, -3.0)


  eID = ECS.Templates.ForwardJumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -0.33, 7.44, 2.17)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -10.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -14.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -17.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)





  turrets[3] = {}
  turrets[3]["eid"] = PROJ_1
  turrets[3]["timer"] = 0
  turrets[3]["shootRate"] = 4
  turrets[3]["force"] = 300

 
  turrets[4] = {}
  turrets[4]["eid"] = PROJ_2
  turrets[4]["timer"] = 1
  turrets[4]["shootRate"] = 4
  turrets[4]["force"] = 300

  
  turrets[5] = {}
  turrets[5]["eid"] = PROJ_3
  turrets[5]["timer"] = 2
  turrets[5]["shootRate"] = 4
  turrets[5]["force"] = 300

  turrets[6] = {}
  turrets[6]["eid"] = PROJ_4
  turrets[6]["timer"] = 3
  turrets[6]["shootRate"] = 4
  turrets[6]["force"] = 300

  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)

  bCID = ECS.getComponentID("BulletObject", FIRST_RED)
  ECS.BulletObject.applyTorque(bCID, 0, 0, 1500)

  Turret.updateTurrets(turrets, dt)


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