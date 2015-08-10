/* global exports */
"use strict";

// module Data.Foreign.OOFFI

exports.method0Impl = function(fnName, o) {
  return o[fnName]();
}

exports.method0EffImpl = function(fnName, o) {
  return function() {
    return o[fnName]();
  };
}

exports.method1Impl = function(fnName, o, a) {
  return o[fnName](a);
}

exports.method1EffImpl = function(fnName, o, a) {
  return function() {
    return o[fnName](a);
  };
}

exports.method2Impl = function(fnName, o, a, b) {
  return o[fnName](a, b);
}

exports.method2EffImpl = function(fnName, o, a, b) {
  return function() {
    return o[fnName](a, b);
  };
}

exports.method3Impl = function(fnName, o, a, b, c) {
  return o[fnName](a, b, c);
}

exports.method3EffImpl = function(fnName, o, a, b, c) {
  return function() {
    return o[fnName](a, b, c);
  };
}

exports.method4Impl = function(fnName, o, a, b, c, e) {
  return o[fnName](a, b, c, e);
}

exports.method4EffImpl = function(fnName, o, a, b, c, e) {
  return function() {
    return o[fnName](a, b, c, e);
  };
}

exports.method5Impl = function(fnName, o, a, b, c, e, f) {
  return o[fnName](a, b, c, e, f);
}

exports.method5EffImpl = function(fnName, o, a, b, c, e, f) {
  return function(){
    return o[fnName](a, b, c, e, f);
  };
}

exports.getterImpl = function(propName, o) {
  return function(){
    return o[propName];
  };
}

exports.modifierImpl = function(propName, o, fn){
  return function() {
    o[propName] = fn(o[propName]);
    return o[propName];
  };
}

exports.setterImpl = function(propName, o, v) {
  return function() {
    o[propName] = v;
    return v;
  };
}

exports.instantiate0FromImpl = function(string, o) {
  return function() {
    return new o[string]();
  };
}

exports.instantiate1FromImpl = function(string, o, x) {
  return function() {
    return new o[string](x);
  };
}

exports.instantiate2FromImpl = function(string, o, x, y) {
  return function() {
    return new o[string](x, y);
  };
}

exports.instantiate3FromImpl = function(string, o, x, y, z) {
  return function() {
    return new o[string](x, y, z);
  };
}

exports.instantiate4FromImpl = function(string, o, w, x, y, z) {
  return function() {
    return new o[string](w, x, y, z);
  };
}

exports.instantiate5FromImpl = function(string, o, v, w, x, y, z) {
  return function() {
    return new o[string](v, w, x, y, z);
  };
}
