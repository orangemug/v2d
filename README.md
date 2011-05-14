# V2D

V2D is a super simple 2D vector library for javascript with a priority on ease of use and clean syntax.


## API
The following examples are all written in [coffeescript](http://jashkenas.github.com/coffee-script), if you're not using it yet you should go do that now. To create a new vector you can pass either an array, two args or an existing vector.

    v = new V2D(1,3)
    v = new V2D([3,5])
    
    # Using an existing vector
    v1 = new V2D([3,5])
    v2 = new V2D(v1)

Although passing `new V2D` each time gets a bit of a pain, therefore I'd suggest either setting it locally in the scope of the class as a private method

    class SomeRandomKlass    
      v2d = v2d   # You can then use v2d(2,3) without the `new` keyword.

Or assgining it to the window object, there is a helper for this. The helper will make `$v` available, and will be use for the remainder of the examples.

    V2D.includeHelper()  # => Then use $v(9,8) anywhere

Below are a list of methods availble for your newly created vector. By convention modifying methods always return a **new** instance of `Vec2d` rather than altering the object itself.

    # Base vector
    v = $v(4,5)
    
    # Sample arguments
    vector = $v(2,3)
    number = 3 

    v.equal(vector)  # Tests for value equality
    v.length() 
    v.lengthSq()
    v.add(vector)
    v.minus(vector)
    v.times(number)
    v.divide(number)
    v.norm()         # Makes the vector unit length
    v.toString()
    v.toArray()
    v.dup()          # Creates a new instance
    v.round()        # Rounds to 0 decimal places

When passing in a _vector_ to any of the above methods it can either be an existing vector

    v1 = $v(0,0)
    v2 = $v(2,3)
    v1.add(v2)

Or using the arg/array syntax as shown previously.

    v1 = $v(0,0)
    v1.add(2,3)
    v1.add([2,3])


## Build/Test
To build/minify simply run the following from the base directory, you'll need coffeescript installed to use `cake`

    cake build

All the tests are run the in browser using [jasmine](http://pivotal.github.com/jasmine), the following command starts a server which hosts the tests

    cake test


