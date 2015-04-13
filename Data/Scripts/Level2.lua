LargeBlade = require "Data/Scripts/LargeBladeFuncs"


messageTime = 100000.0
messageQueue = {}
flags = {}

function onGameBuild()
  eIDBlade = LargeBlade.generate(19,3,6)

  cIDBlade = ECS.getComponentID("BulletObject", eIDBlade)
  cIDPlatform = ECS.getComponentID("BulletObject", 11)
  ECS.BulletObject.Constraint.addFixed(cIDBlade,"Whatever",cIDPlatform,0,0,0)


end


function onGameUpdate (dt)
  ECS.BulletObject.applyTorque(4, -50000)
  ECS.BulletObject.applyTorque(11, 2000)

  messageTime = messageTime + dt


  --[[
  if messageTime > 5.0 then
    Client.setMessage(" ")
  end
  if messageTime > 5.5 then
    if tablelength(messageQueue) > 0 then
      Client.setMessage(table.remove(messageQueue, 1))
      messageTime = 0.0
    else 
      Client.hideHUD()
    end
  end
  --]]
  pEID = State.getPlayer()
  playerPosCID = ECS.getComponentID("Position", pEID)
  x, y, z = ECS.Position.getPosition(playerPosCID)
  Client.setMessage(string.format("%d, %d, %d", x, y, z))
end

function onRingContact(id)
  print(id)
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

Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)
Vorb.register("onGameBuild", onGameBuild)
