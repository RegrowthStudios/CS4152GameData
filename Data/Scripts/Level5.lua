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
FIRST_RED = 8
FIRST_GREEN = 5
FIRST_BLACK = 6
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
  ECS.Position.setPosition(cID, 0.5, 7.4, 2.17)
  ECS.Position.setOrientation(cID, 0.0, -0.036, -3.0)

  eID = ECS.Templates.ForwardJumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -0.33, 7.44, 2.17)
  ECS.Position.setOrientation(cID, 0.0, -0.036, -3.0)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -8.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -11.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -15.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)





  PROJ_5 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_5)
  ECS.Position.setPosition(cID, -7.0, 0, -31.5)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_6 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_6)
  ECS.Position.setPosition(cID, -7.0, 0, -33.0)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_7 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_7)
  ECS.Position.setPosition(cID, -7.0, 0, -35.0)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_8 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_8)
  ECS.Position.setPosition(cID, -7.0, 0, -36.5)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)


  PROJ_9 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_9)
  ECS.Position.setPosition(cID, -7.0, 0, -56.0)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_10 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_10)
  ECS.Position.setPosition(cID, -7.0, 0, -57.5)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_11 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_11)
  ECS.Position.setPosition(cID, -7.0, 0, -58.5)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)

  PROJ_12 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_12)
  ECS.Position.setPosition(cID, -7.0, 0, -59.5)
  ECS.Position.setOrientation(cID, math.pi, -math.pi/2, 2.2)




  turrets[1] = {}
  turrets[1]["eid"] = PROJ_1
  turrets[1]["timer"] = 0
  turrets[1]["shootRate"] = 4
  turrets[1]["force"] = 300

 
  turrets[2] = {}
  turrets[2]["eid"] = PROJ_2
  turrets[2]["timer"] = 1
  turrets[2]["shootRate"] = 4
  turrets[2]["force"] = 300

  
  turrets[3] = {}
  turrets[3]["eid"] = PROJ_3
  turrets[3]["timer"] = 2
  turrets[3]["shootRate"] = 4
  turrets[3]["force"] = 300

  turrets[4] = {}
  turrets[4]["eid"] = PROJ_4
  turrets[4]["timer"] = 3
  turrets[4]["shootRate"] = 4
  turrets[4]["force"] = 300

  turrets[5] = {}
  turrets[5]["eid"] = PROJ_5
  turrets[5]["timer"] = 0
  turrets[5]["shootRate"] = 2
  turrets[5]["force"] = 400

  turrets[6] = {}
  turrets[6]["eid"] = PROJ_6
  turrets[6]["timer"] = 0.5
  turrets[6]["shootRate"] = 2
  turrets[6]["force"] = 400

  turrets[7] = {}
  turrets[7]["eid"] = PROJ_7
  turrets[7]["timer"] = 1.0
  turrets[7]["shootRate"] = 2
  turrets[7]["force"] = 400

  turrets[8] = {}
  turrets[8]["eid"] = PROJ_8
  turrets[8]["timer"] = 1.5
  turrets[8]["shootRate"] = 2
  turrets[8]["force"] = 400

  turrets[9] = {}
  turrets[9]["eid"] = PROJ_9
  turrets[9]["timer"] = 0
  turrets[9]["shootRate"] = 4
  turrets[9]["force"] = 150

  turrets[10] = {}
  turrets[10]["eid"] = PROJ_10
  turrets[10]["timer"] = 1.0
  turrets[10]["shootRate"] = 4
  turrets[10]["force"] = 150

  turrets[11] = {}
  turrets[11]["eid"] = PROJ_11
  turrets[11]["timer"] = 2.0
  turrets[11]["shootRate"] = 4
  turrets[11]["force"] = 150

  turrets[12] = {}
  turrets[12]["eid"] = PROJ_12
  turrets[12]["timer"] = 3.0
  turrets[12]["shootRate"] = 4
  turrets[12]["force"] = 150


  bCID = ECS.getComponentID("BulletObject", FIRST_BLACK)
  ECS.BulletObject.setMass(bCID, 0)

  rrfCID = ECS.getComponentID("RingRotationFactor", FIRST_GREEN)
  ECS.RingRotationFactor.set(rrfCID, 2.75)



  eID = ECS.Templates.ForwardJumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 2.75, -13.1, -56.5)
  ECS.Position.setOrientation(cID, 0.0, -0.031, 0.234)

  eID = ECS.Templates.ForwardJumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 5.15, -12.43, -56.5)
  ECS.Position.setOrientation(cID, 0.0, -0.031, 0.234)


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -12.9, -3.4, -53.5)
  ECS.Position.setOrientation(cID, 3.14, -1.4, 1.2)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -12.9, -3.4, -51.5)
  ECS.Position.setOrientation(cID, 3.14, -1.4, 1.2)



  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -5.12, -12.43, -55.7)
  ECS.Position.setOrientation(cID, 0.0, -0.117, -0.399)


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -3.48, -13.0, -59.55)
  ECS.Position.setOrientation(cID, -3.14, 0.119, 0.286)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -1.75, -13.34, -55.7)
  ECS.Position.setOrientation(cID, 0.0, -0.117, -0.399)



  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -1.27, 0.65, -76.1)
  ECS.Position.setOrientation(cID, -3.14, 0.042, 1.108)


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
    Client.hideHUD()
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