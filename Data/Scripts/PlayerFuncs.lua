local Player = {}
local messageTime = 100000.0
local messageQueue = {}

function Player.setLight(rings, currentRing)
  local colorSet = false
  lightCID = ECS.getComponentID("Light", State.getPlayerFeet())

  for index, ring in pairs(rings) do
    if ring["eid"] == currentRing and ring["color"] == "green" then
      ECS.Light.set(lightCID, 10, 0, 1.5, 0)
      colorSet = true   
    elseif ring["eid"] == currentRing and ring["color"] == "red" then
      ECS.Light.set(lightCID, 10, 1.5, 0, 0)
      colorSet = true   
    elseif ring["eid"] == currentRing and ring["color"] == "goal" then
      ECS.Light.set(lightCID, 10, 0.25, 1.25, 1.5)
      colorSet = true  
    end
  end
  if not colorSet then
    ECS.Light.set(lightCID, 10, 0.5, 0.5, 0.5)
  end
end

function Player.checkAddMessage(rings, currentRing)
  for index, ring in pairs(rings) do
    if ring["eid"] == currentRing and ring["message"] ~= false and not ring["touched"] then
      table.insert(messageQueue, ring["message"])
      ring["touched"] = true
    end
  end
end

function Player.processMessageQueue(dt)
  messageTime = messageTime + dt
  if messageTime > 5.0 then
    Client.hideHUD()
  end
  if messageTime > 5.0 then
    if tablelength(messageQueue) > 0 then
      message = table.remove(messageQueue, 1)
      Client.setMessage(message)
      -- Client.Sound.play2D(message.fx, 1.0)
      messageTime = 0.0 
    end
  end
end

Vorb.register("Update.Player", function(eID, dt)
  local cIDPhys = ECS.getComponentID("BulletObject", eID)
  local r = ECS.BulletObject.getSpeed(cIDPhys)
  r = math.pow(r, 1.2) / 14.0
  r = math.min(1.0, math.max(0.0, r))
  Client.Renderer.DoF.setLensArea(8 - 4 * r)
  Client.Renderer.Bloom.setPower(1 + 6 * r)
  Client.Renderer.Bloom.setSize(0.01 + 0.01 * r)
  Client.Renderer.HDR.setGamma(1 + 0.3 * r)
  Client.Renderer.HDR.setExposure(1 + 0.8 * r)
end)

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

return Player