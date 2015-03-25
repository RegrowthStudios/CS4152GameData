timeElapsed = 0.0
math.randomseed( os.time() )
projectileInterval = math.random(10,20)  
projectileCounter=0

function onGameUpdate (dt)
  -- Increment Game Time
  timeElapsed = timeElapsed + dt
  --print(math.floor(math.fmod(timeElapsed,20)))

  --if math.floor(math.fmod(timeElapsed,projectileInterval))==0 then
	--eid=ECS.Templates.Projectile()
	--ECS.Templates.applyForce(gameState,eid,0,0,0)
  --end

end
 
function onTurretUpdate(entityID,dt)

	if math.floor(math.fmod(projectileCounter,projectileInterval))==0 then
		componentID=ECS.getComponentID("Position",entityID)
		x,y,z=ECS.Position.getPosition(componentID)
		--Put projectile into the position turrent/ set position
		eid=ECS.Templates.Projectile()
		componentID=ECS.getComponentID("Position",eid)
		ECS.Position.setPosition(componentID,x,y,z)
		componentID=ECS.getComponentID("BulletObject",eid)
		ECS.BulletObject.createBody(componentID)
		ECS.BulletObject.applyForce(componentID,x,y,z)
	end
	projectileCounter=projectileCounter+1
end

Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onTurretUpdate",onTurretUpdate)