# Creates private methods and attaches them to `__privateMethods__` on the prototype.
# Useful because you can then test private methods.
Function::privateMethods = (a) ->
  s = this
  for m of a
    f = () ->
      return a[m].apply(s,arguments)
    eval("#{m}=f")

  # For specs
  this.__privateMethods__ = a


###
# 2D vector library written with ease of use in mind.
###
class V2D
  constructor: (args...) ->
    if args[0] instanceof V2D
      v = args[0]
      args = [v.x, v.y]
    else if args.length == 1 && args[0] instanceof Array
      args = args[0]

    @x or= args[0] ? 0
    @y or= args[1] ? 0

  # Define some private methods
  @privateMethods
    'parseArg': (arg, arg2) ->
      if arg2
        arg = new V2D(arg,arg2)        
      else if arg instanceof Array
        arg = new V2D(arg[0],arg[1])
      return arg    

  # Simplifies init
  #    new V2D([5,8])
  # becomes
  #    v2d([5,8])
  @includeHelper: (obj) ->
    h = (args...) ->
      new V2D(args...)  

    obj or= window
    obj.$v = h
    if obj.prototype
      obj::$v = h


  # Compare
  equal: (args...) ->
    v = parseArg(args...)
    (@x == v.x && @y == v.y)


  # Length of a vector
  length: () ->
    Math.sqrt( @x*@x + @y*@y )


  # Squared length of a vector
  lengthSq: () ->
    ( @x * @x + @y * @y )


  # Addition
  add: (args...) ->
    v = parseArg(args...)
    new V2D( @x + v.x, @y + v.y )


  # Minus
  minus: (args...) ->
    v = parseArg(args...)
    new V2D( @x - v.x, @y - v.y )


  # Multiplication
  # n = number multiplier
  times: (n) ->
  	new V2D( @x * n, @y * n )


  # Division
  # n = number to divide by
  divide: (n) ->
	  new V2D( @x/n, @y/n )


  # Normal
  norm: () ->
	  l = this.length()
	  new V2D( @x/l, @y/l )


  # Overides javascript toString method
  toString: () ->
	  "[#{@x},#{@y}]"


  # Overides javascript toString method
  toArray: () ->
	  [@x,@y]


  # Duplicates the vector
  dup: () ->
	  new V2D( @x , @y )


  # Round to integer vector
  round: () ->
	  new V2D( Math.round(@x) ,Math.round(@y) )


  # Perpendicular to current vector.
  perp: () ->
  	# TODO

# Make available to the window.
window.V2D = V2D
