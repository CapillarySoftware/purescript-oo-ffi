## Purescript OO FFI
[![Build Status](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi.svg?branch=master)](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi)

A collection of helper functions for binding into foreign OO style apis

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
""" :: forall e. Obj -> Eff (mutation :: Mutation | e) Unit
```

Object Oriented Foriegn Function Interface provides functions to 
handle boilerplate when binding onto JavaScript objects.

```purescript
  add :: Obj -> Number -> Number -> Number
  add = method2 "add"
  
  inc :: forall e. Obj -> Eff (mutation :: Mutation | e) Unit
  inc = method0Eff "inc"
```

Much neater. 

```purescript
method2 :: String -> objectWithMethod -> firstArgToMethod -> secondArgToMethod -> returnType
```

The `String` in the first argument is property you are binding to. 

OO-FFI functions are in the following format `method<number of argumentes>` for pure functions and `method<number of arguments>Eff` for `Eff`ectful functions.

---

Mutable properties

```
`var foo = { bar : 0 };
```

```purescript
getBar :: forall e. Foo -> Eff { myMutable :: Mutable | e } Number
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




