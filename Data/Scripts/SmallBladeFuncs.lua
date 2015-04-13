local SmallBlade = {}


function SmallBlade.generate(x, y, z)
  eIDSmallBlade = ECS.Templates.SmallBlade()
  cIDSmallBlade = ECS.getComponentID("BulletObject", eIDSmallBlade)
  ECS.BulletObject.createBody(cIDSmallBlade)
  ECS.BulletObject.setPosition(cIDSmallBlade, x, y, z)
  ECS.Position.setPosition(cIDSmallBlade, x, y, z)  
  return eIDSmallBlade
end

return SmallBlade