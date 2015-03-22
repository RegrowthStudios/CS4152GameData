function onGameUpdate (dt)
  State_setRingMass(gameState, 0, 0)
  State_applyRingTorque(gameState, 2, 30000)
end

function registerFuncs (env)
  register(env, "onGameUpdate", "onGameUpdate")
end
