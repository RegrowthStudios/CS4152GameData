Debug = require "Data/Scripts/DebugFuncs"
Turret = require "Data/Scripts/TurretFuncs"
Player = require "Data/Scripts/PlayerFuncs"

-- turrets is a table of all of the different turrets in the level
turrets = {}

rings = {}
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = 8
rings["first_green"]["message"] = false
rings["first_green"]["touched"] = false
rings["second_green"] = {}
rings["second_green"]["color"] = "green"
rings["second_green"]["eid"] = 9
rings["second_green"]["message"] = false
rings["second_green"]["touched"] = false
rings["first_black"] = {}
rings["first_black"]["color"] = "black"
rings["first_black"]["eid"] = 11
rings["first_black"]["message"] = false
rings["first_black"]["touched"] = false
rings["third_green"] = {}
rings["third_green"]["color"] = "green"
rings["third_green"]["eid"] = 10
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
  ECS.RingRotationFactor.set(rrfCID, 1.75)


  bCID = ECS.getComponentID("BulletObject", rings["first_black"]["eid"])
  ECS.BulletObject.setMass(bCID, 0)



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
  ECS.Position.setPosition(cID, -6.88, 2.84, 26.4)
  ECS.Position.setOrientation(cID, 0.0, -0.012, -1.96)

    eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 2.2, 0.6, 24.35)
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

  Turret.updateTurrets(turrets, dt)
  Debug.show(currentRing)
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