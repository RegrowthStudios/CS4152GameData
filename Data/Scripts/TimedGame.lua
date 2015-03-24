goalTime = 6.0
timeElapsed = 0.0

function onGameUpdate (dt)
  -- Increment Game Time
  timeElapsed = timeElapsed + dt
  
  if timeElapsed > goalTime then
    -- Debug Print
    print("Lolz, you suck, I'll give you 10 extra seconds")
    goalTime = goalTime + 10.0

    -- Set To End State (Does Nothing Yet)
    State_setGameState(gameState, 100)
  else
    -- Show Countdown
    print(goalTime - timeElapsed)
  end
end

Vorb.register("onGameUpdate", onGameUpdate)
