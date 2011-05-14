_loadSingle = CoffeeScript.load
CoffeeScript.load = (arr, callback, first=true) ->
  # Revese the array so the load finishes up
  if first
    arr = arr.reverse()

  if !(item = arr.pop())
    callback?()
    return

  _loadSingle item, () ->
    CoffeeScript.load arr, callback, false
