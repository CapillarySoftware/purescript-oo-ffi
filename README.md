## Purescript OO FFI
[![Build Status](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi.svg?branch=master)](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi)
[![Bower version](https://badge.fury.io/bo/purescript-oo-ffi.svg)](http://badge.fury.io/bo/purescript-oo-ffi)
[![Code Climate](https://codeclimate.com/github/CapillarySoftware/purescript-oo-ffi/badges/gpa.svg)](https://codeclimate.com/github/CapillarySoftware/purescript-oo-ffi)
[![Dependencies](https://david-dm.org/CapillarySoftware/purescript-oo-ffi.png)](https://david-dm.org/CapillarySoftware/purescript-oo-ffi)

A collection of helper functions for binding into foreign OO style apis

> [paf31's Post including an explaination of this lib.](https://gist.github.com/paf31/8e9177b20ee920480fbc#purescript-oo-ffi)

---

Lets say we want to bind into the following object, defined with foreign data type `Obj`.
```javascript
var obj = {
  val : 0,
  add : function(x, y,) {
    return x + y;
  }
  inc : function(){
    obj.val++;
  }
};
```

FFI alone is quite a bit of boilerplate
```purescript
foreign import add """
  function add(obj){
    return function(x){
      return function(y){
        return obj.add(x, y);
      };
    };
  }
""" :: Obj -> Number -> Number -> Number

foreign import inc """
  function inc(obj){
    return function(){
      obj.inc();
    };
  }
""" :: forall e. Obj -> Eff (myMutable :: MyMutable | e) Unit
```

Object Oriented Foriegn Function Interface provides functions to 
handle boilerplate when binding onto JavaScript objects.

```purescript
  add :: Obj -> Number -> Number -> Number
  add = method2 "add"
  
  inc :: forall e. Obj -> Eff (myMutable :: MyMutable | e) Unit
  inc = method0Eff "inc"
```

Much neater. Here's how it works:

```purescript
method2 :: String -> objectWithMethod -> firstArgToMethod -> secondArgToMethod -> returnValue
```

The `String` in the first argument is name of the property you are binding to. 

`method` bindings are in the following format `method<number of arguments>` for pure functions and `method<number of arguments>Eff` for Effectful functions.

---

Mutable properties are also assisted.

```javascript
var foo = { bar : 0 };
```

```purescript
getBar :: forall e. Foo -> Eff { myMutable :: MyMutable | e } Number
getBar = getter "bar"

modifyBar :: forall e. Foo -> (Number -> Number) -> Eff { myMutable :: MyMutable | e } Number
modifyBar = modifier "bar"

setBar :: forall e. Foo -> Number -> Eff { myMutable :: MyMutable | e } Number
setBar = setter "bar"

main = do
  b  <- getBar foo
  b' <- setBar foo 1
  modifyBar foo \x -> x + 1
  b'' <- getBar foo
  assert $ b   == 0
  assert $ b'  == 1
  assert $ b'' == 2
```




