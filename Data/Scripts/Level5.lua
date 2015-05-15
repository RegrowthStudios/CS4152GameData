Debug = require "Data/Scripts/DebugFuncs"
Turret = require "Data/Scripts/TurretFuncs"
Player = require "Data/Scripts/PlayerFuncs"

-- turrets is a table of all of the different turrets in the level
turrets = {}

FIRST_RED = 8
FIRST_GREEN = 5
FIRST_BLACK = 6

rings = {}
rings["first_grey"] = {}
rings["first_grey"]["color"] = "grey"
rings["first_grey"]["eid"] = 4
rings["first_grey"]["message"] = "Being hit by a PROJECTILE will hurt you."
rings["first_grey"]["touched"] = false
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = FIRST_GREEN
rings["first_green"]["message"] = false
rings["first_green"]["touched"] = false
rings["first_black"] = {}
rings["first_black"]["color"] = "black"
rings["first_black"]["eid"] = FIRST_BLACK
rings["first_black"]["message"] = "PROJECTILES will destroy LASER TURRETS."
rings["first_black"]["touched"] = false
rings["first_red"] = {}
rings["first_red"]["color"] = "red"
rings["first_red"]["eid"] = FIRST_RED
rings["first_red"]["message"] = false
rings["first_red"]["touched"] = false
rings["goal"] = {}
rings["goal"]["color"] = "goal"
rings["goal"]["eid"] = 7
rings["goal"]["message"] = false
rings["goal"]["touched"] = false


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

  -- grey ring turrets

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

  -- green ring turrets

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

  -- turret table controls turret behavior
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
  turrets[5]["shootRate"] = 3
  turrets[5]["force"] = 400

  turrets[6] = {}
  turrets[6]["eid"] = PROJ_6
  turrets[6]["timer"] = 0.66
  turrets[6]["shootRate"] = 3
  turrets[6]["force"] = 400

  turrets[7] = {}
  turrets[7]["eid"] = PROJ_7
  turrets[7]["timer"] = 1.33
  turrets[7]["shootRate"] = 3
  turrets[7]["force"] = 400

  turrets[8] = {}
  turrets[8]["eid"] = PROJ_8
  turrets[8]["timer"] = 2.33
  turrets[8]["shootRate"] = 3
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
  ECS.BulletObject.applyTorque(bCID, 0, 0, 1300)

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