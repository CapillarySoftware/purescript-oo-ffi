module Data.Foreign.OOFFI 
  ( method0, method0Eff
  , method1, method1Eff
  , method2, method2Eff
  , method3, method3Eff
  , method4, method4Eff
  , getter, modifier, setter) where

import Data.Function
import Control.Monad.Eff



foreign import method0Impl
  "function method0Impl(fnName, o){\
  \  return o[fnName]();\
  \}" :: forall o e. Fn2 String o e

method0 = runFn2 method0Impl

foreign import method0EffImpl
  "function method0EffImpl(fnName, o){\
  \  return function(){\
  \    return o[fnName]();\
  \  };\
  \}" :: forall o e. Fn2 String o e

method0Eff = runFn2 method0EffImpl



foreign import method1Impl
  "function method1Impl(fnName, o, a){\
  \  return o[fnName](a);\
  \}" :: forall o a e. Fn3 String o a e

method1 = runFn3 method1Impl

foreign import method1EffImpl
  "function method1EffImpl(fnName, o, a){\
  \  return function(){\
  \    return o[fnName](a);\
  \  };\
  \}" :: forall o a e. Fn3 String o a e

method1Eff = runFn3 method1EffImpl



foreign import method2Impl
  "function method2Impl(fnName, o, a, b){\
  \  return o[fnName](a, b);\
  \}" :: forall o a b e. Fn4 String o a b e

method2 = runFn4 method2Impl

foreign import method2EffImpl
  "function method2EffImpl(fnName, o, a, b){\
  \  return function(){\
  \    return o[fnName](a, b);\
  \  };\
  \}" :: forall o a b e. Fn4 String o a b e

method2Eff = runFn4 method2EffImpl



foreign import method3Impl
  "function method3Impl(fnName, o, a, b, c){\
  \  return o[fnName](a, b, c);\
  \}" :: forall o a b c e. Fn5 String o a b c e

method3 = runFn5 method3Impl

foreign import method3EffImpl
  "function method3EffImpl(fnName, o, a, b, c){\
  \  return function(){\
  \    return o[fnName](a, b, c);\
  \  };\
  \}" :: forall o a b c e. Fn5 String o a b c e

method3Eff = runFn5 method3EffImpl



foreign import method4Impl
  "function method4Impl(fnName, o, a, b, c, e){\
  \  return o[fnName](a, b, c, e);\
  \}" :: forall o a b c e' e. Fn6 String o a b c e' e

method4 = runFn6 method4Impl

foreign import method4EffImpl
  "function method4EffImpl(fnName, o, a, b, c, e){\
  \  return function(){\
  \    return o[fnName](a, b, c, e);\
  \  };\
  \}" :: forall o a b c e' e. Fn6 String o a b c e' e

method4Eff = runFn6 method4EffImpl



foreign import getterImpl
  "function getterImpl(propName, o){\
  \  return function(){\
  \    return o[propName];\
  \  };\
  \}" :: forall o e. Fn2 String o e

getter = runFn2 getterImpl



foreign import modifierImpl
  "function modifierImpl(propName, o, fn){\
  \  return function(){\
  \    o[propName] = fn(o[propName]);\
  \    return o[propName];\
  \  };\
  \}" :: forall o f e. Fn3 String o f e

modifier = runFn3 modifierImpl



foreign import setterImpl
  "function setterImpl(propName, o, v){\
  \  return function(){\
  \    o[propName] = v;\
  \    return v;\
  \  };\
  \}" :: forall o v e. Fn3 String o v e

setter = runFn3 setterImpl