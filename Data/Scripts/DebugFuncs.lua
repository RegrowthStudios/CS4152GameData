local Debug = {}

function Debug.setInfo(lineOne, lineTwo, lineThree, lineFour, lineFive)
  print("called here")
  Client.setDebugInfo(lineOne, lineTwo, lineThree, lineFour, lineFive)
end



return Debug