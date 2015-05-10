-- Spawning function
local spawnStack = {}
function spawnEntity(name)
  return function (unused, x, y, z)
    local eID = ECS.Templates[name]()
    local cIDPos = ECS.getComponentID("Position", eID)
    ECS.Position.setPosition(cIDPos, x, y, z)
    table.insert(spawnStack, eID)
  end
end

function orientLikePlayer(eID)
  pEID = State.getPlayer()
  playerPosCID = ECS.getComponentID("Position", pEID)
  qx, qy, qz, qw = ECS.BulletObject.getQuaternion(playerPosCID)
  tCID = ECS.getComponentID("Position", eID)
  ECS.Position.setQuaternion(tCID, qx, qy, qz, qw)
end

function popLastSpawnedEntity ()
  if #spawnStack > 0 then
    local eID = spawnStack[#spawnStack]
    table.remove(spawnStack, #spawnStack)
    return eID
  else
    return 0
  end
end
function killLastSpawned ()
  local eID = popLastSpawnedEntity()
  if eID ~= 0 then
    State.kill(eID)
  end
end

function printLocation (eID, x, y, z)
  print(string.format("Mouse selected %f at (%f,%f,%f)", eID, x, y, z))
end

-- The editor functions
mpf = printLocation;
function mouseEditorFunction (eID, x, y, z)
  mpf(eID, x, y, z)
end

Vorb.register("onMouseEdit", mouseEditorFunction)
