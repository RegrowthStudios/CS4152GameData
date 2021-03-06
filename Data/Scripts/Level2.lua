Debug = require "Data/Scripts/DebugFuncs"
Player = require "Data/Scripts/PlayerFuncs"


rings = {}
rings["first_green"] = {}
rings["first_green"]["color"] = "green"
rings["first_green"]["eid"] = 6
rings["first_green"]["message"] = "You can push around GREY RINGS with GREEN RINGS."
rings["first_green"]["touched"] = false
rings["second_grey"] = {}
rings["second_grey"]["color"] = "green"
rings["second_grey"]["eid"] = 7
rings["second_grey"]["message"] = "You can push a GREY RING around to create a bridge."
rings["second_grey"]["touched"] = false
rings["second_green"] = {}
rings["second_green"]["color"] = "green"
rings["second_green"]["eid"] = 9
rings["second_green"]["message"] = "You can get back up using the YELLOW JUMP PADS."
rings["second_green"]["touched"] = false
rings["goal"] = {}
rings["goal"]["color"] = "goal"
rings["goal"]["eid"] = 8
rings["goal"]["message"] = false
rings["goal"]["touched"] = false

currentRing = 0

function onGameBuild()
  --Client.Renderer.setMode("Low")
  --Client.Renderer.DoF.setActive(false)
  --Client.Renderer.MotionBlur.setActive(false)
  --[[
  eID = ECS.Templates.Torch()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -0.92, -7.2, 12.02)
  ECS.Position.setQuaternion(cID, 0.125, 0.947, -0.038, 0.292)


  eID = ECS.Templates.RomanArch ()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 2.57, -14.29, -21.6)
  ECS.Position.setQuaternion(cID, -0.102, 0.700, -0.132, -0.689)
  ]]




  -- Make end portal
  eID = ECS.Templates.Portal()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, 8.0, -43.0)
  ECS.Position.setQuaternion(cID, 1.0, 0.0, 0.0, 0.0)


  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -9.2, -10.3, -22.0)
  ECS.Position.setQuaternion(cID, -0.44, -0.127, -0.26, 0.96)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, -9.2, -10.3, -23.5)
  ECS.Position.setQuaternion(cID, -0.44, -0.127, -0.26, 0.96)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 10.1, 8.3, -22.0)
  ECS.Position.setQuaternion(cID, 0.65, -0.167, 0.73, -0.01)

  eID = ECS.Templates.JumpPad()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 10.1, 8.3, -23.5)
  ECS.Position.setQuaternion(cID, 0.65, -0.167, 0.73, -0.01)

  -- Make fixed ring
  bCID = ECS.getComponentID("BulletObject", 11)
  ECS.BulletObject.setMass(bCID, 0)

  bCID = ECS.getComponentID("BulletObject", 12)
  ECS.BulletObject.setMass(bCID, 0)

  rrfCID = ECS.getComponentID("RingRotationFactor", rings["first_green"]["eid"])
  ECS.RingRotationFactor.set(rrfCID, 0.75)

  rrfCID = ECS.getComponentID("RingRotationFactor", rings["second_green"]["eid"])
  ECS.RingRotationFactor.set(rrfCID, 6.0)
  
  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
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