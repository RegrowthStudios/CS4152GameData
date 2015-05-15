Debug = require "Data/Scripts/DebugFuncs"
Turret = require "Data/Scripts/TurretFuncs"
Player = require "Data/Scripts/PlayerFuncs"

-- turrets is a table of all of the different turrets in the level
turrets = {}

rings = {}
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = 5
rings["first_green"]["message"] = false
rings["first_green"]["touched"] = false
rings["second_green"] = {}
rings["second_green"]["color"] = "green"
rings["second_green"]["eid"] = 6
rings["second_green"]["message"] = false
rings["second_green"]["touched"] = false
rings["first_black"] = {}
rings["first_black"]["color"] = "black"
rings["first_black"]["eid"] = 10
rings["first_black"]["message"] = false
rings["first_black"]["touched"] = false
rings["third_green"] = {}
rings["third_green"]["color"] = "green"
rings["third_green"]["eid"] = 8
rings["third_green"]["message"] = false
rings["third_green"]["touched"] = false


function onGameBuild()
  --Client.Renderer.setMode("Low")

  -- set up rings
  rrfCID = ECS.getComponentID("RingRotationFactor", rings["first_green"]["eid"])
  ECS.RingRotationFactor.set(rrfCID, 1.75)

  rrfCID = ECS.getComponentID("RingRotationFactor", rings["second_green"]["eid"])
  ECS.RingRotationFactor.set(rrfCID, 1.75)
  
  rrfCID = ECS.getComponentID("RingRotationFactor", rings["third_green"]["eid"])
  ECS.RingRotationFactor.set(rrfCID, 5.0)


  


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -6.88, -2.8, 22.8)
  ECS.Position.setOrientation(cID, 3.14, -1.57, 1.9)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -0.4, -2.4, -1.7)
  ECS.Position.setOrientation(cID, -3.14, 0.06, 2.35)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -1.5, -1.5, -1.7)
  ECS.Position.setOrientation(cID, 3.14, 0.06, 2.35)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -6.88, 2.84, 26.4)
  ECS.Position.setOrientation(cID, 0.0, -0.012, -1.96)


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 3.25, -1.2, 22.35)
  ECS.Position.setOrientation(cID, 0.0, 0.175, 1.2)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 3.25, 1.6, 22.35)
  ECS.Position.setOrientation(cID, 0.0, -0.13, 2)


  -- tutorial turrets on first ring, firing into blades
  PROJ_1 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_1)
  ECS.Position.setPosition(cID, -1.5, 7.5, 9.5)
  ECS.Position.setOrientation(cID, -math.pi, 1.17, 0.18)

  PROJ_2 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_2)
  ECS.Position.setPosition(cID, -1.5, 7.5, 10.0)
  ECS.Position.setOrientation(cID, 0.0, math.pi/2, -2.8)

  PROJ_3 = ECS.Templates.Turret()
  cID = ECS.getComponentID("Position", PROJ_3)
  ECS.Position.setPosition(cID, -1.5, 7.5, 10.5)
  ECS.Position.setOrientation(cID,  0.0, 1.17, -2.8)


  -- turret table controls turret behavior
  turrets[1] = {}
  turrets[1]["eid"] = PROJ_1
  turrets[1]["timer"] = 0
  turrets[1]["shootRate"] = 1
  turrets[1]["force"] = 500

  turrets[2] = {}
  turrets[2]["eid"] = PROJ_2
  turrets[2]["timer"] = .33
  turrets[2]["shootRate"] = 1
  turrets[2]["force"] = 500
  
  turrets[3] = {}
  turrets[3]["eid"] = PROJ_3
  turrets[3]["timer"] = .66
  turrets[3]["shootRate"] = 1
  turrets[3]["force"] = 500


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 9.7, -3.8, -13.2)
  ECS.Position.setOrientation(cID, 3.14, 1.5, -1.94)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -9.37, -1.25, -29.2)
  ECS.Position.setOrientation(cID, -0.0, -0.021, -1.442)


  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.01, 7.3, -42.25)
  ECS.Position.setOrientation(cID, 3.14, -0.227, 0.007)

  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)

  Turret.updateTurrets(turrets, dt)
  Player.processMessageQueue(dt)
end

function onRingContact(id)
  currentRing = id
  Player.setLight(rings, currentRing)
  Player.checkAddMessage(rings, currentRing)
end

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)