/* global exports */
"use strict";

// module Data.Foreign.OOFFI

exports.getter = function(prop) {
  return function(obj) {
    return function() {
      return obj[prop];
    }
  }
}

exports.modifier = function(prop) {
  return function(obj) {
    return function(fn) {
      return function() {
        var val = fn(obj[prop]);
        obj[prop] = val;
        return val;
      }
    }
  }
}

exports.setter = function(prop) {
  return function(obj) {
    return function(val) {
      return function() {
        obj[prop] = val;
        return val;
      }
    }
  }
}

// See http://stackoverflow.com/questions/1606797/use-of-apply-with-new-operator-is-this-possible
exports.instantiateImpl = function(cls) {
  return function() {
    var len = arguments.length;
    var args = new Array(len);
    args[0] = null;
    for (var i = 0; i < len; i++) {
      args[i + 1] = arguments[i];
    }
    return function() {
      return new (Function.prototype.bind.apply(cls, args));
      //return cls.apply(Object.create(cls.prototype), args);
    }
  }
}

exports.mapEff = function(fn) {
  return function() {
    var args = arguments;
    return function() {
      return fn.apply(null, args);
    }
  }
}

exports.unsafeGetter = function(prop) {
  return function(obj) {
    return obj[prop];
  }
}
