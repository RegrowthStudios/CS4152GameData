local LargeBlade = {}


function LargeBlade.generate(x, y, z)
  eIDLargeBlade = ECS.Templates.LargeBlade()
  cIDLargeBlade = ECS.getComponentID("BulletObject", eIDLargeBlade)
  ECS.BulletObject.createBody(cIDLargeBlade)
  ECS.BulletObject.setPosition(cIDLargeBlade, x, y, z)
  ECS.Position.setPosition(cIDLargeBlade, x, y, z)  
  return eIDLargeBlade
end

return LargeBlade