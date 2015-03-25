messageTime = 100000.0
messageQueue = {}
flags = {}
flags["touched3"] = false
flags["touched5"] = false
flags["touched7"] = false


function onGameUpdate (dt)
  messageTime = messageTime + dt
  if messageTime > 6.0 then
    if tablelength(messageQueue) > 0 then
      Client.setMessage(table.remove(messageQueue, 1))
      messageTime = 0.0
    else 
      Client.setMessage(" ")
    end
  end
end

function onRingContact(id) 
  if id == 3 and not flags["touched3"] then 
    table.insert(messageQueue, "I just erased your memory, so you might feel a bit confused about your environment.")
    table.insert(messageQueue, "I just erased your memory, so you might feel a bit confused about your environment.")

    flags["touched3"] = true 
  end
  if id == 5 and not flags["touched5"] then
    table.insert(messageQueue, "Oh, so you left that first ring?  Neat.")
    flags["touched5"] = true
  end
  if id == 7 and not flags["touched7"] then
    table.insert(messageQueue, "You've got circuits in your brain that let you rotate green rings like this one.")
    flags["touched7"] = true
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

Vorb.register("onGameUpdate", onGameUpdate)
Vorb.register("onRingContact", onRingContact)
