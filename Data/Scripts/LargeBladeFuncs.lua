local LargeBlade = {}


function LargeBlade.generate(x, y, z)
  eIDLargeBlade = ECS.Templates.LargeBlade()
  cIDLargeBlade = ECS.getComponentID("BulletObject", eIDLargeBlade)
  ECS.BulletObject.createBody(cIDLargeBlade)
  ECS.BulletObject.setPosition(cIDLargeBlade, x, y, z)
  cIDPos = ECS.getComponentID("Position", eIDLargeBlade)
  ECS.Position.setPosition(cIDPos, x, y, z)  
  return eIDLargeBlade
end

return LargeBlade