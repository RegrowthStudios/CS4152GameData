Debug = require "Data/Scripts/DebugFuncs"
Player = require "Data/Scripts/PlayerFuncs"


rings = {}
rings["first_grey"] = {}
rings["first_grey"]["color"] = "grey"
rings["first_grey"]["eid"] = 5
rings["first_grey"]["message"] = "Use WASD to roll, and the MOUSE to look around."
rings["first_grey"]["touched"] = false
rings["second_grey"] = {}
rings["second_grey"]["color"] = "grey"
rings["second_grey"]["eid"] = 8
rings["second_grey"]["message"] = "Use SPACEBAR to jump."
rings["second_grey"]["touched"] = false
rings["third_grey"] = {}
rings["third_grey"]["color"] = "grey"
rings["third_grey"]["eid"] = 9
rings["third_grey"]["message"] = "Hold W and press SPACEBAR repeatedly to roll up walls."
rings["third_grey"]["touched"] = false
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = 4
rings["first_green"]["message"] = "You can rotate GREEN RINGS with Q and E."
rings["first_green"]["touched"] = false
rings["second_green"] = {}
rings["second_green"]["color"] = "green"
rings["second_green"]["eid"] = 6
rings["second_green"]["message"] = "GREEN RINGS are blocked by BLACK RINGS."
rings["second_green"]["touched"] = false
rings["goal"] = {}
rings["goal"]["color"] = "goal"
rings["goal"]["eid"] = 7
rings["goal"]["message"] = "Throw yourself into the BLUE FLAMES."
rings["goal"]["touched"] = false

currentRing = 0

function onGameBuild()
  --Client.Renderer.setMode("Low")

  -- Create End Portal
  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 1.5, 11.26, -53.0)
  ECS.Position.setQuaternion(cID, 0.73, -0.06, -0.67, -0.05)

  -- Make rings rotatable by player
  rrfCID = ECS.getComponentID("RingRotationFactor", 4)
  ECS.RingRotationFactor.set(rrfCID, 1.5)

  rrfCID = ECS.getComponentID("RingRotationFactor", 6)
  ECS.RingRotationFactor.set(rrfCID, 1.5)

  -- make fixed ring
  bCID = ECS.getComponentID("BulletObject", 10)
  ECS.BulletObject.setMass(bCID, 0)



end

function onGameUpdate (dt)
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