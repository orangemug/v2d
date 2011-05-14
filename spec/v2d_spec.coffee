# Include the global `$v` helper
V2D.includeHelper()

describe "V2D", () ->

  # Add some custom matchers
  beforeEach () ->
    @addMatchers
      toBeCloseTo: (expected, precision) ->
        if !(precision == 0)
          precision = precision || 2
        multiplier = Math.pow(10, precision)
        actual = Math.round(this.actual * multiplier)
        expected = Math.round(expected * multiplier)
        return expected == actual

      toBeInstanceOf: (klass) ->
        this.actual instanceof klass


  # Test helpers
  it "can include global helper", ->
    # Included in top of script
    expect($v).toBeDefined()

  it "can init without global helper", ->
    v = new V2D(5,6)
    expect(v.x).toEqual(5)
    expect(v.y).toEqual(6)

  it "can init using global helper", ->
    v = $v(5,6)
    expect(v.x).toEqual(5)
    expect(v.y).toEqual(6)

  it "include helper in an class", ->
    class TmpClass
      V2D.includeHelper(this)
      test: () ->
        @$v(6,7)

    tc = new TmpClass()
    v = tc.test()
    expect(v.x).toEqual(6)
    expect(v.y).toEqual(7)

  it "include helper in an class instance", ->
    class TmpClass
      constructor: ->
        V2D.includeHelper(this)
      test: () ->
        @$v(8,1)

    tc = new TmpClass()
    v = tc.test()
    expect(v.x).toEqual(8)
    expect(v.y).toEqual(1)


  # Private methods.
  it "can parseArg as an array", ->
    v = V2D.__privateMethods__.parseArg [0,6]
    expect(v).toBeInstanceOf(V2D)
    expect(v.x).toEqual(0)
    expect(v.y).toEqual(6)

  it "can parseArg as an args", ->
    v = V2D.__privateMethods__.parseArg 0,6
    expect(v).toBeInstanceOf(V2D)
    expect(v.x).toEqual(0)
    expect(v.y).toEqual(6)
    

  # Public methods
  it "can init with existsing vector", ->
    v1 = $v(2,3)
    v2 = $v(v1)
    expect(v2).toBeInstanceOf(V2D)
    expect(v2.x).toEqual(2)
    expect(v2.y).toEqual(3)
    expect(v2).toNotBe(v1)
  
  it "should be equal", ->
    v = $v(6,7)
    result = v.equal(6,7)
    expect(result).toBeTruthy()

  it "calculate length to 2dp", ->
    l = $v(3,3).length()
    expect(l).toBeCloseTo(4.24)

  it "calculate length squared", ->
    l = new V2D([3,3]).lengthSq()
    expect(l).toBeCloseTo(18)

  it "should be able to add", ->
    v = $v(1,1)
    v = v.add(5,7)
    expect(v.x).toEqual(6)
    expect(v.y).toEqual(8)

  it "should be able to subtract", ->
    v = $v(1,1)
    v = v.minus(5,7)
    expect(v.x).toEqual(-4)
    expect(v.y).toEqual(-6)

  it "should be able to multiply", ->
    v = $v(1,2)
    v = v.times(4)
    expect(v.x).toEqual(4)
    expect(v.y).toEqual(8)

  it "should be able to divide", ->
    v = $v(8,4)
    v = v.divide(4)
    expect(v.x).toEqual(2)
    expect(v.y).toEqual(1)

  it "should be able to calculate the normal", ->
    v = $v(32,32)
    v = v.norm()
    expect(v.x).toBeCloseTo(0.71)
    expect(v.y).toBeCloseTo(0.71)

  it "should be represented as a string", ->
    v = $v(40,89)
    expect("#{v}").toEqual("[40,89]")

  it "should be represented as an array", ->
    arr = $v(40,89).toArray()
    expect(arr).toEqual([40,89])

  it "should be duplicated", ->
    v1 = $v(40,89)
    v2 = v1.dup()
    expect(v1).toNotBe(v2)

  it "should round correctly", ->
    v = $v(67.6753,34.4449).round()
    expect(v.x).toEqual(68)
    expect(v.y).toEqual(34)


