## Purescript OO FFI
[![Build Status](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi.svg?branch=master)](https://travis-ci.org/CapillarySoftware/purescript-oo-ffi)
[![Bower version](https://badge.fury.io/bo/purescript-oo-ffi.svg)](http://badge.fury.io/bo/purescript-oo-ffi)
[![Dependency Status](https://www.versioneye.com/user/projects/5491b268dd709d2cfc0001b1/badge.svg?style=flat)](https://www.versioneye.com/user/projects/5491b268dd709d2cfc0001b1)

PureScript Object Oriented Foreign Function Interface is a collection of helper functions for binding into foreign OO style apis

> [paf31's Post including an explaination of this lib.](https://gist.github.com/paf31/8e9177b20ee920480fbc#purescript-oo-ffi)

---

### Methods

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

FFI alone is quite a bit of boilerplate:

`MyModule.js`:
```javascript
exports.add = function (obj) {
  return function(x) {
    return function(y) {
      return obj.add(x, y);
    };
  };
}

exports.inc = function (obj) {
  return function() {
    obj.inc();
  };
}
```

`MyModule.purs`:
```purescript
foreign import data Obj :: *
foreign import data MyMutable :: !

foreign import add :: Obj -> Number -> Number -> Number

foreign import inc :: forall e. Obj -> Eff (myMutable :: MyMutable | e) Unit
```

Object Oriented Foriegn Function Interface provides functions to
handle boilerplate when binding onto JavaScript objects.

`MyModule.purs`:
```purescript
foreign import data Obj :: *
foreign import data MyMutable :: !

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

### Get Set and Modify

Mutable properties are also assisted.

```javascript
var foo = { bar : 0 };
```

```purescript
foreign import data Foo :: *
foreign import data MyMutable :: !

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

### Instantiate

Shortcuts for the Instantiation of Object Oriented Classes is supported on two layers.

```javascript
function Foo(x){
  this.x = x;
}
```

```purescript
foreign import data Foo :: *
foreign import data NewFoo :: !

newFoo :: forall a e. a -> Eff (foo :: NewFoo | e) Foo
newFoo = instantiate1 "Foo"
```

This will pull `Foo` off the the global context (`window` or `global` or `self`) like so `new window["Foo"]`. The pattern here is `instantiate<number of arguments>`

If the library you are binding to holds its Object Oriented Classes inside a NameSpace like this:

```javascript
var Lib = {
  Foo : function(x){ this.x; }
};

foo = new Lib.Foo(0);
```

Then use the `instantiateNFrom` functions

```purescript
foreign import data Foo :: *
foreign import data Lib :: *
foreign import data NewFoo :: !

foreign import lib "var lib = Lib" :: Lib

newFoo :: forall a e. a -> Eff (foo :: NewFoo | e) Foo
newFoo = "Foo" `instantiate1From` lib
```

The pattern here is `instantiate<number of arguments>From`.

### Binding to Globals

Lets say you wish to bind to something on the global context. For example:

```javascript
context.setTimeout(fn, milliseconds);
```

Helper methods are provided with patterns:
```
method<number of arguments>C
method<number of arguments>EffC
```

so you can bind like so:

```purescript
timeout :: forall e a. Eff (timer :: Timer | e) a -> Milliseconds -> Eff (timer :: Timer | e) Timeout
timeout = method2EffC "setTimeout"
```

where `C` indicates Global Context (`window` or `global` or `self`).

This also works for getters and setters.

```javascript
context.foo = 3;
```

```purescript
getFoo :: forall e. Eff e Number
getFoo = getterC "foo"
```
