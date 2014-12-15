module Data.Foreign.OOFFI
  ( method0, method0Eff
  , method1, method1Eff
  , method2, method2Eff
  , method3, method3Eff
  , method4, method4Eff
  , method5, method5Eff
  , getter, modifier, setter
  , instantiate0, instantiate0From
  , instantiate1, instantiate1From
  , instantiate2, instantiate2From
  , instantiate3, instantiate3From
  , instantiate4, instantiate4From
  , instantiate5, instantiate5From ) where

import Data.Function
import Control.Monad.Eff
import Context


foreign import method0Impl
  "function method0Impl(fnName, o){\
  \  return o[fnName]();\
  \}" :: forall o ret. Fn2 String o ret

method0 = runFn2 method0Impl

foreign import method0EffImpl
  "function method0EffImpl(fnName, o){\
  \  return function(){\
  \    return o[fnName]();\
  \  };\
  \}" :: forall o a eff. Fn2 String o (Eff eff a)

method0Eff = runFn2 method0EffImpl



foreign import method1Impl
  "function method1Impl(fnName, o, a){\
  \  return o[fnName](a);\
  \}" :: forall o a ret. Fn3 String o a ret

method1 = runFn3 method1Impl

foreign import method1EffImpl
  "function method1EffImpl(fnName, o, a){\
  \  return function(){\
  \    return o[fnName](a);\
  \  };\
  \}" :: forall o a b eff. Fn3 String o a (Eff eff b)

method1Eff = runFn3 method1EffImpl



foreign import method2Impl
  "function method2Impl(fnName, o, a, b){\
  \  return o[fnName](a, b);\
  \}" :: forall o a b ret. Fn4 String o a b ret

method2 = runFn4 method2Impl

foreign import method2EffImpl
  "function method2EffImpl(fnName, o, a, b){\
  \  return function(){\
  \    return o[fnName](a, b);\
  \  };\
  \}" :: forall o a b c eff. Fn4 String o a b (Eff eff c)

method2Eff = runFn4 method2EffImpl



foreign import method3Impl
  "function method3Impl(fnName, o, a, b, c){\
  \  return o[fnName](a, b, c);\
  \}" :: forall o a b c ret. Fn5 String o a b c ret

method3 = runFn5 method3Impl

foreign import method3EffImpl
  "function method3EffImpl(fnName, o, a, b, c){\
  \  return function(){\
  \    return o[fnName](a, b, c);\
  \  };\
  \}" :: forall o a b c d eff. Fn5 String o a b c (Eff eff d)

method3Eff = runFn5 method3EffImpl



foreign import method4Impl
  "function method4Impl(fnName, o, a, b, c, e){\
  \  return o[fnName](a, b, c, e);\
  \}" :: forall o a b c e ret. Fn6 String o a b c e ret

method4 = runFn6 method4Impl

foreign import method4EffImpl
  "function method4EffImpl(fnName, o, a, b, c, e){\
  \  return function(){\
  \    return o[fnName](a, b, c, e);\
  \  };\
  \}" :: forall o a b c e f eff. Fn6 String o a b c e (Eff eff f)

method4Eff = runFn6 method4EffImpl



foreign import method5Impl
  "function method5Impl(fnName, o, a, b, c, e, f){\
  \  return o[fnName](a, b, c, e, f);\
  \}" :: forall o a b c e f ret. Fn7 String o a b c e f ret

method5 = runFn7 method5Impl

foreign import method5EffImpl
  "function method5EffImpl(fnName, o, a, b, c, e, f){\
  \  return function(){\
  \    return o[fnName](a, b, c, e, f);\
  \  };\
  \}" :: forall o a b c e f g eff. Fn7 String o a b c e f (Eff eff g)

method5Eff = runFn7 method5EffImpl



foreign import getterImpl
  "function getterImpl(propName, o){\
  \  return function(){\
  \    return o[propName];\
  \  };\
  \}" :: forall o a eff. Fn2 String o (Eff eff a)

getter = runFn2 getterImpl



foreign import modifierImpl
  "function modifierImpl(propName, o, fn){\
  \  return function(){\
  \    o[propName] = fn(o[propName]);\
  \    return o[propName];\
  \  };\
  \}" :: forall o a b eff. Fn3 String o (a -> b) (Eff eff b)

modifier = runFn3 modifierImpl



foreign import setterImpl
  "function setterImpl(propName, o, v){\
  \  return function(){\
  \    o[propName] = v;\
  \    return v;\
  \  };\
  \}" :: forall o v eff. Fn3 String o v (Eff eff v)

setter = runFn3 setterImpl




foreign import instantiate0FromImpl """
  function instantiate0FromImpl(string, o){
    return function(){
      return new o[string]();
    };
  }""" :: forall a o e. Fn2 String o (Eff e a)

instantiate0From = runFn2 instantiate0FromImpl

instantiate0 :: forall a e. String -> Eff e a
instantiate0 s = getContext >>= instantiate0From s 

foreign import instantiate1FromImpl """
  function instantiate1FromImpl(string, o, x){
    return function(){
      return new o[string](x);
    };
  }""" :: forall a b o e. Fn3 String o a (Eff e b)

instantiate1From = runFn3 instantiate1FromImpl

instantiate1 :: forall a b e. String -> a -> Eff e b
instantiate1 s a = getContext >>= \c -> instantiate1From s c a 

foreign import instantiate2FromImpl """
  function instantiate2FromImpl(string, o, x, y){
    return function(){
      return new o[string](x, y);
    };
  }""" :: forall a b c o e. Fn4 String o a b (Eff e c)

instantiate2From = runFn4 instantiate2FromImpl

instantiate2 :: forall a b c e. String -> a -> b -> Eff e c
instantiate2 s a b = getContext >>= \c -> instantiate2From s c a b

foreign import instantiate3FromImpl """
  function instantiate3FromImpl(string, o, x, y, z){
    return function(){
      return new o[string](x, y, z);
    };
  }""" :: forall a b c d o e. Fn5 String o a b c (Eff e d)

instantiate3From = runFn5 instantiate3FromImpl

instantiate3 :: forall a b c d e. String -> a -> b -> c -> Eff e d
instantiate3 s a b c = getContext >>= \c' -> instantiate3From s c' a b c 

foreign import instantiate4FromImpl """
  function instantiate4FromImpl(string, o, w, x, y, z){
    return function(){
      return new o[string](w, x, y, z);
    };
  }""" :: forall a b c d e f o. Fn6 String o a b c d (Eff e f)

instantiate4From = runFn6 instantiate4FromImpl

instantiate4 :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e  
instantiate4 s a b c d = getContext >>= \c' -> instantiate4From s c' a b c d

foreign import instantiate5FromImpl """
  function instantiate5FromImpl(string, o, v, w, x, y, z){
    return function(){
      return new o[string](v, w, x, y, z);
    };
  }""" :: forall a b c d e f g o. Fn7 String o a b c d f (Eff e g)

instantiate5From = runFn7 instantiate5FromImpl

instantiate5 :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
instantiate5 s a b c d e = getContext >>= \c' -> instantiate5From s c' a b c d e