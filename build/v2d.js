(function() {
  var V2D;
  var __slice = Array.prototype.slice;
  Function.prototype.privateMethods = function(a) {
    var f, m, s;
    s = this;
    for (m in a) {
      f = function() {
        return a[m].apply(s, arguments);
      };
      eval("" + m + "=f");
    }
    return this.__privateMethods__ = a;
  };
  /*
  # 2D vector library written with ease of use in mind.
  */
  V2D = (function() {
    function V2D() {
      var args, v, _ref, _ref2;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if (args[0] instanceof V2D) {
        v = args[0];
        args = [v.x, v.y];
      } else if (args.length === 1 && args[0] instanceof Array) {
        args = args[0];
      }
      this.x || (this.x = (_ref = args[0]) != null ? _ref : 0);
      this.y || (this.y = (_ref2 = args[1]) != null ? _ref2 : 0);
    }
    V2D.privateMethods({
      'parseArg': function(arg, arg2) {
        if (arg2) {
          arg = new V2D(arg, arg2);
        } else if (arg instanceof Array) {
          arg = new V2D(arg[0], arg[1]);
        }
        return arg;
      }
    });
    V2D.includeHelper = function(obj) {
      var h;
      h = function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return (function(func, args, ctor) {
          ctor.prototype = func.prototype;
          var child = new ctor, result = func.apply(child, args);
          return typeof result == "object" ? result : child;
        })(V2D, args, function() {});
      };
      obj || (obj = window);
      obj.$v = h;
      if (obj.prototype) {
        return obj.prototype.$v = h;
      }
    };
    V2D.prototype.equal = function() {
      var args, v;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      v = parseArg.apply(null, args);
      return this.x === v.x && this.y === v.y;
    };
    V2D.prototype.length = function() {
      return Math.sqrt(this.x * this.x + this.y * this.y);
    };
    V2D.prototype.lengthSq = function() {
      return this.x * this.x + this.y * this.y;
    };
    V2D.prototype.add = function() {
      var args, v;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      v = parseArg.apply(null, args);
      return new V2D(this.x + v.x, this.y + v.y);
    };
    V2D.prototype.minus = function() {
      var args, v;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      v = parseArg.apply(null, args);
      return new V2D(this.x - v.x, this.y - v.y);
    };
    V2D.prototype.times = function(n) {
      return new V2D(this.x * n, this.y * n);
    };
    V2D.prototype.divide = function(n) {
      return new V2D(this.x / n, this.y / n);
    };
    V2D.prototype.norm = function() {
      var l;
      l = this.length();
      return new V2D(this.x / l, this.y / l);
    };
    V2D.prototype.toString = function() {
      return "[" + this.x + "," + this.y + "]";
    };
    V2D.prototype.toArray = function() {
      return [this.x, this.y];
    };
    V2D.prototype.dup = function() {
      return new V2D(this.x, this.y);
    };
    V2D.prototype.round = function() {
      return new V2D(Math.round(this.x), Math.round(this.y));
    };
    V2D.prototype.perp = function() {};
    return V2D;
  })();
  window.V2D = V2D;
}).call(this);
