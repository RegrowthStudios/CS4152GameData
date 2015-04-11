local LargeSpike = {}


function LargeSpike.generate(x, y, z)
  eIDLargeSpike = ECS.Templates.LargeSpike()
  cIDLargeSpike = ECS.getComponentID("BulletObject", eIDLargeSpike)
  ECS.BulletObject.createBody(cIDLargeSpike)
  ECS.BulletObject.setPosition(cIDLargeSpike, x, y, z)
  ECS.Position.setPosition(cIDLargeSpike, x, y, z)  
  return eIDLargeSpike
end

return LargeSpike