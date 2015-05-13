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

FIRST_GREEN = 5
FIRST_BLACK = 6
SECOND_GREEN = 9
FIRST_RED = 8
EID_ROTATING_TURRET_1=0

function onGameBuild()
  Debug.potato()

  -- tutorial turrets on first ring, firing into blades
  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 5.27, -5.27, 7.7)
  ECS.Position.setQuaternion(cID, -0.37, 0.926, 0.010, 0.024)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 5.95, -5.95, 10.7)
  ECS.Position.setQuaternion(cID, 0.005, -0.011, 0.397, 0.981)


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 6.8, 0.0, 13.4)
  ECS.Position.setQuaternion(cID, -0.005, 0.005, 0.694, 0.719)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.4, 0.0, 10.0)
  ECS.Position.setQuaternion(cID, -0.005, 0.005, 0.694, 0.719)
  


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -7.4, -1.01, -23.1)
  ECS.Position.setQuaternion(cID, 0.65, 0.75, -0.012, 0.013)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, -7.4, -23.1)
  ECS.Position.setQuaternion(cID, 0.011, 1.0, 0.0, -0.01)

  rrfCID = ECS.getComponentID("RingRotationFactor", FIRST_GREEN)
  ECS.RingRotationFactor.set(rrfCID, 1.75)

  -- add the lasers to the fixed black ring
  bCID = ECS.getComponentID("BulletObject", FIRST_BLACK)
  ECS.BulletObject.setMass(bCID, 0)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 7.42, 3.4, -22.4)
  ECS.Position.setQuaternion(cID, 0.016, -0.015, 0.717, 0.697)


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 7.27, 1.65, -27.4)
  ECS.Position.setQuaternion(cID, 0.78, -0.624, 0.011, 0.009)


  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.3, 2.0, -22.4)
  ECS.Position.setQuaternion(cID, 0.016, -0.015, 0.717, 0.697)


  -- sweep this laser on this ring over the other lasers

  EID_ROTATING_TURRET_1  = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", EID_ROTATING_TURRET_1)
  ECS.Position.setPosition(cID, 5.9, -4.89, -40.0)
  ECS.Position.setQuaternion(cID, -0.546, 0.838, 0.002, 0.004)

  rrfCID = ECS.getComponentID("RingRotationFactor", SECOND_GREEN)
  ECS.RingRotationFactor.set(rrfCID, 3.2)



  -- these three projectile turrets are grouped together on the second ring, creating a timing challenge
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

  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)
  if EID_ROTATING_TURRET_1 ~= 0 then
    cID = ECS.getComponentID("Position", EID_ROTATING_TURRET_1)
    ex, ey, ez = ECS.Position.getOrientation(cID)
    ECS.Position.setOrientation(cID, 0, 3.14, ez)
  end
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