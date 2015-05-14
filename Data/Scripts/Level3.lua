Debug = require "Data/Scripts/DebugFuncs"
Player = require "Data/Scripts/PlayerFuncs"

currentRing = 0

FIRST_RED_RING = 10
SECOND_RED_RING = 5
THIRD_RED_RING = 7

rings = {}
rings["first_red"] = {}
rings["first_red"]["color"] = "red"
rings["first_red"]["eid"] = FIRST_RED_RING
rings["first_red"]["message"] = "RED RINGS rotate at a set speed."
rings["first_red"]["touched"] = false
rings["second_red"] = {}
rings["second_red"]["color"] = "red"
rings["second_red"]["eid"] = SECOND_RED_RING
rings["second_red"]["message"] = false
rings["second_red"]["touched"] = false
rings["third_red"] = {}
rings["third_red"]["color"] = "red"
rings["third_red"]["eid"] = THIRD_RED_RING
rings["third_red"]["message"] = false
rings["third_red"]["touched"] = false
rings["last_grey"] = {}
rings["last_grey"]["color"] = "grey"
rings["last_grey"]["eid"] = 6
rings["last_grey"]["message"] = "The BLADES on this ring are sharp."
rings["last_grey"]["touched"] = false


function onGameBuild()
  -- Enable compatability with potato computers
  --Client.Renderer.setMode("Low")

  -- Place blades hanging overing spinning ring
  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -52.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 8.5, 0.0, -48.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, 2.1)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -8.5, 0.0, -52.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, -1.3)

  eID = ECS.Templates.LargeBlade()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -8.5, 0.0, -48.0)
  ECS.Position.setOrientation(cID, -1.57, 0.0, -1.3)

  -- Create two end portals

  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 6.2, -6.3, -58.0)
  ECS.Position.setQuaternion(cID, -0.22, 0.57, 0.29, 0.73)

  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -6.2, 6.3, -58.0)
  ECS.Position.setQuaternion(cID, -0.22, 0.57, 0.29, 0.73)

  
  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)

end

function onGameUpdate (dt)
  -- spin rings
  bCID = ECS.getComponentID("BulletObject", FIRST_RED_RING)
  ECS.BulletObject.applyTorque(bCID, 0, 0, 1250)

  bCID = ECS.getComponentID("BulletObject", SECOND_RED_RING)
  ECS.BulletObject.applyTorque(bCID, 0, 0, -1750)

  bCID = ECS.getComponentID("BulletObject", THIRD_RED_RING)
  ECS.BulletObject.applyTorque(bCID, 0, 0, 1500)

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