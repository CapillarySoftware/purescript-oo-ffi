module Data.Foreign.OOFFI
  ( method0, method0Eff
  , method1, method1Eff
  , method2, method2Eff
  , method3, method3Eff
  , method4, method4Eff
  , method5, method5Eff
  , getter, modifier, setter
  , instantiate0
  , instantiate1
  , instantiate2
  , instantiate3
  , instantiate4
  , instantiate5 ) where

import Data.Function
import Control.Monad.Eff



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




foreign import instantiate0 """
  function instantiate0(string){
    return function(){
      return new window[string]();
    };
  }""" :: forall a e. String -> Eff e a

foreign import instantiate1Impl """
  function instantiate1Impl(string, x){
    return function(){
      return new window[string](x);
    };
  }""" :: forall a b e. Fn2 String a (Eff e b)

instantiate1 = runFn2 instantiate1Impl

foreign import instantiate2Impl """
  function instantiate2Impl(string, x, y){
    return function(){
      return new window[string](x, y);
    };
  }""" :: forall a b c e. Fn3 String a b (Eff e c)

instantiate2 = runFn3 instantiate2Impl

foreign import instantiate3Impl """
  function instantiate3Impl(string, x, y, z){
    return function(){
      return new window[string](x, y, z);
    };
  }""" :: forall a b c d e. Fn4 String a b c (Eff e d)

instantiate3 = runFn4 instantiate3Impl

foreign import instantiate4Impl """
  function instantiate4Impl(string, w, x, y, z){
    return function(){
      return new window[string](w, x, y, z);
    };
  }""" :: forall a b c d e f. Fn5 String a b c d (Eff e f)

instantiate4 = runFn5 instantiate4Impl

foreign import instantiate5Impl """
  function instantiate5Impl(string, v, w, x, y, z){
    return function(){
      return new window[string](v, w, x, y, z);
    };
  }""" :: forall a b c d e f g. Fn6 String a b c d f (Eff e g)

instantiate5 = runFn6 instantiate5Impl