Debug = require "Data/Scripts/DebugFuncs"


messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched4"] = false
flags["touched6"] = false
flags["touched7"] = false
flags["touched8"] = false
flags["touched12"] = false
currentRing = 0


function onGameBuild()


  eID = ECS.Templates.RomanArch()
  cID = ECS.getComponentID("Position", eID)
  ECS.Position.setPosition(cID, 0.0, -8.0, -45.0)

  -- Make rings rotatable by player
  rrfCID = ECS.getComponentID("RingRotationFactor", 4)
  ECS.RingRotationFactor.set(rrfCID, 0.9)

  rrfCID = ECS.getComponentID("RingRotationFactor", 6)
  ECS.RingRotationFactor.set(rrfCID, 0.9)

  --loadMusic()
  -- Client.Sound.playMusicTrack("Electronic", 7.0)
end

function onGameUpdate (dt)
  messageTime = messageTime + dt
  if messageTime > 5.0 then
    Client.setMessage(" ")
  end
  if messageTime > 5.5 then
    if tablelength(messageQueue) > 0 then
      message = table.remove(messageQueue, 1)
      Client.setMessage(message.message)
      -- Client.Sound.play2D(message.fx, 1.0)
      messageTime = 0.0
    else 
      Client.hideHUD()
    end
  end
  pEID = State.getPlayer()
  playerPosCID = ECS.getComponentID("Position", pEID)
  playerBulletCID = ECS.getComponentID("BulletObject", pEID)
  x, y, z = ECS.Position.getPosition(playerPosCID)
  qx, qy, qz, qw = ECS.BulletObject.getQuaternion(playerBulletCID)
  posStr = string.format("%g, %g, %g", x, y, z)
  quatStr = string.format("%.3f, %.3f, %.3f, %.3f", qx, qy, qz, qw)
  ringStr = string.format("Current Ring: %d", currentRing)
  Debug.setInfo(posStr, quatStr, ringStr, "other", "other")
end

function createMessage(narration, strMessage)
  msg = {}
  msg["fx"] = narration
  msg["message"] = strMessage
  return msg
end

function onRingContact(id)
  currentRing = id
  if id == 3 and not flags["touched3"] then
    table.insert(messageQueue, createMessage("Narrative0", "I recently erased your memory,"))
    table.insert(messageQueue, createMessage("Narrative1", "so you might feel a bit confused about your environment."))
    flags["touched3"] = true 
  end
  if id == 5 and not flags["touched5"] then
    table.insert(messageQueue, createMessage("Narrative2", "Oh, so you left that first ring?  Neat."))
    table.insert(messageQueue, createMessage("Narrative3", "Spacebar to jump."))
    flags["touched5"] = true
  end
  if id == 6 and not flags["touched6"] then
    table.insert(messageQueue, createMessage("Narrative4", "You're on the Array,"))
    table.insert(messageQueue, createMessage("Narrative5", "the last record of humanity in the universe."))
    flags["touched6"] = true
  end
  if id == 7 and not flags["touched7"] then
    table.insert(messageQueue, createMessage("Narrative6", "You can rotate green rings like this one with Q and E."))
    flags["touched7"] = true
  end
  if id == 11 and not flags["touched11"] then
    table.insert(messageQueue, createMessage("Narrative7", "DON'T TOUCH THAT ORANGE."))
    flags["touched11"] = true
  end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
--[[ 

Dialogue for Level 1:
onStart:
"Good morning, or night, I'm not sure. 
I just erased your memory, so you might be feeling 
a bit confused about your environment."

"You're the only inhabitant of The Array, humanity's last message 
to the stars.  When humans realized
they weren't going to make it, they put all their interesting 
stuff onto these rings, and shot it out into space with just you 
you and me to watch over it."

"Gravity or centrifigual force or whatever holds stuff to the inner 
surface of the rings, as you can see.  So you can walk around, and 
down becomes up and up becomes down."

"Oh, you left that ring?  Well, I guess you want to go exploring.
I would too if I'd just had my memory wiped, I guess.  We can 
go look at the Eiffel Tower on the other side of this bunch of rings."

"You've got circuits wired into your brain that let you 
rotate certain rings; the green ones to be specific.  Just press
Q and E, now that you're standing on the green ring, and it'll rotate. 
With your brain."

"You should be able to make it over to the Eiffel Tower now, if you 
insist on seeing it.  Be careful not to fall off the rings,
you *are* the last human alive, you know."

"So, we're at the Eiffel Tower.  Take a nice look at it.  It's going 
to be gone soon."

"Don't touch the computer core.  You want to stay on this set of rings, 
the other rings are much less hospitable.  And you don't want to destroy 
my computing resources, or else I won't be able to destroy you!  And the
universe will be much better off without all this crap, and you, in it."






--]]

Vorb.register("onGameBuild", onGameBuild)
Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)