Debug = require "Data/Scripts/DebugFuncs"
Turret = require "Data/Scripts/TurretFuncs"
Player = require "Data/Scripts/PlayerFuncs"

FIRST_GREEN = 5
FIRST_BLACK = 6
SECOND_GREEN = 7
FIRST_RED = 9
currentRing = 0
rings = {}
rings["first_grey"] = {}
rings["first_grey"]["color"] = "grey"
rings["first_grey"]["eid"] = 4
rings["first_grey"]["message"] = "Being hit by a LASER will result in death."
rings["first_grey"]["touched"] = false
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = FIRST_GREEN
rings["first_green"]["message"] = false
rings["first_green"]["touched"] = false
rings["first_black"] = {}
rings["first_black"]["color"] = "black"
rings["first_black"]["eid"] = FIRST_BLACK
rings["first_black"]["message"] = "LASERS will also kill LASER TURRETS."
rings["first_black"]["touched"] = false
rings["second_green"] = {}
rings["second_green"]["color"] = "green"
rings["second_green"]["eid"] = SECOND_GREEN
rings["second_green"]["message"] = false
rings["second_green"]["touched"] = false
rings["first_red"] = {}
rings["first_red"]["color"] = "red"
rings["first_red"]["eid"] = FIRST_RED
rings["first_red"]["message"] = false
rings["first_red"]["touched"] = false
rings["goal"] = {}
rings["goal"]["color"] = "purple"
rings["goal"]["eid"] = 10
rings["goal"]["message"] = false
rings["goal"]["touched"] = false



function onGameBuild()
  --Client.Renderer.setMode("Low")
  -- tutorial turrets on first ring, firing into blades


  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 5.2, -5.2, 6.75)
  ECS.Position.setQuaternion(cID, -0.37, 0.926, 0.010, 0.024)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 6.5, 0.0, 12.5)
  ECS.Position.setQuaternion(cID, -0.005, 0.005, 0.694, 0.719)
  
  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -7.4, -1.01, -24.1)
  ECS.Position.setQuaternion(cID, 0.65, 0.75, -0.012, 0.013)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.0, -7.4, -24.1)
  ECS.Position.setQuaternion(cID, 0.011, 1.0, 0.0, -0.01)

  rrfCID = ECS.getComponentID("RingRotationFactor", FIRST_GREEN)
  ECS.RingRotationFactor.set(rrfCID, 2.75)

  -- add the lasers to the fixed black ring
  bCID = ECS.getComponentID("BulletObject", FIRST_BLACK)
  ECS.BulletObject.setMass(bCID, 0)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 5.9, 4.5, -24.0)
  ECS.Position.setQuaternion(cID, 0.043, -0.015, 0.920, 0.388)

  eID = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 7.42, 3.4, -29.5)
  ECS.Position.setQuaternion(cID, 0.78, -0.624, 0.011, 0.009)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.0, 3.4, -22.9)
  ECS.Position.setQuaternion(cID, 0.016, -0.015, 0.717, 0.697)

  -- sweep this laser on this ring over the other lasers
  
  EID_ROTATING_TURRET_1  = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", EID_ROTATING_TURRET_1)
  ECS.Position.setPosition(cID, 7.9, 0.95, -42.0)
  ECS.Position.setQuaternion(cID, 0.748, -0.663, 0.002, 0.001)

  rrfCID = ECS.getComponentID("RingRotationFactor", SECOND_GREEN)
  ECS.RingRotationFactor.set(rrfCID, 3.2)

  -- turrets on the red ring
  
  EID_ROTATING_TURRET_2  = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", EID_ROTATING_TURRET_2)
  ECS.Position.setPosition(cID, 7.45, 0.89, -75.5)
  ECS.Position.setQuaternion(cID, 0.752, -0.659, -0.003, -0.003)

  EID_ROTATING_TURRET_3  = ECS.Templates.LaserTurret()
  cID = ECS.getComponentID("Position", EID_ROTATING_TURRET_3)
  ECS.Position.setPosition(cID, -7.28, -0.89, -75.5)
  ECS.Position.setQuaternion(cID, 0.653, 0.757, -0.012, 0.013)

  -- end portal!  yay!  this level was hard to make!

  eID  = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.98, -7.44, -87.5)
  ECS.Position.setQuaternion(cID, -0.12, 0.99, -0.003, -0.02)

  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)
  bCID = ECS.getComponentID("BulletObject", FIRST_RED)
  ECS.BulletObject.applyTorque(bCID, 0, 0, 3000)

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