(function() {
  var _loadSingle;
  _loadSingle = CoffeeScript.load;
  CoffeeScript.load = function(arr, callback, first) {
    var item;
    if (first == null) {
      first = true;
    }
    if (first) {
      arr = arr.reverse();
    }
    if (!(item = arr.pop())) {
      if (typeof callback == "function") {
        callback();
      }
      return;
    }
    return _loadSingle(item, function() {
      return CoffeeScript.load(arr, callback, false);
    });
  };
}).call(this);
