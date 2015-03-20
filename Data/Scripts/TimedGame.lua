goalTime = 6.0
timeElapsed = 0.0

function onGameUpdate (dt)
  -- Increment Game Time
  timeElapsed = timeElapsed + dt
  
  if timeElapsed > goalTime then
    -- Set To End State
    print("Lolz, you suck, I'll give you 0.122 seconds")
    State_setGameState(gameState, 100)
    goalTime = goalTime + 0.122
    make_Turret(gameState)
  else
    -- Show Countdown
    print(goalTime - timeElapsed)
  end
end

function registerFuncs (env)
  register(env, "onGameUpdate", "onGameUpdate")
end
