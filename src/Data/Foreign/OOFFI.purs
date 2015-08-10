module Data.Foreign.OOFFI
  ( method0, method0Eff, method0C, method0EffC
  , method1, method1Eff, method1C, method1EffC
  , method2, method2Eff, method2C, method2EffC
  , method3, method3Eff, method3C, method3EffC
  , method4, method4Eff, method4C, method4EffC
  , method5, method5Eff, method5C, method5EffC
  , getter,   getterC
  , modifier, modifierC
  , setter,   setterC
  , instantiate0, instantiate0From
  , instantiate1, instantiate1From
  , instantiate2, instantiate2From
  , instantiate3, instantiate3From
  , instantiate4, instantiate4From
  , instantiate5, instantiate5From ) where

import Data.Function
import Control.Monad.Eff
import Context

gc = (>>=) getContext

foreign import method0Impl :: forall o ret. Fn2 String o ret

method0    = runFn2 method0Impl
method0C s = gc \c -> method0 s c

foreign import method0EffImpl :: forall o a eff. Fn2 String o (Eff eff a)

method0Eff    = runFn2 method0EffImpl
method0EffC s = gc \c -> method0Eff s c


foreign import method1Impl :: forall o a ret. Fn3 String o a ret

method1      = runFn3 method1Impl
method1C s a = gc \c -> method1 s c a -- creative anachronism?

foreign import method1EffImpl :: forall o a b eff. Fn3 String o a (Eff eff b)

method1Eff      = runFn3 method1EffImpl
method1EffC s a = gc \c -> method1Eff s c a


foreign import method2Impl :: forall o a b ret. Fn4 String o a b ret

method2        = runFn4 method2Impl
method2C s a b = gc \c -> method2 s c a b

foreign import method2EffImpl :: forall o a b c eff. Fn4 String o a b (Eff eff c)

method2Eff        = runFn4 method2EffImpl
method2EffC s a b = gc \c -> method2Eff s c a b


foreign import method3Impl :: forall o a b c ret. Fn5 String o a b c ret

method3          = runFn5 method3Impl
method3C s a b c = gc \c' -> method3 s c' a b c

foreign import method3EffImpl :: forall o a b c d eff. Fn5 String o a b c (Eff eff d)

method3Eff          = runFn5 method3EffImpl
method3EffC s a b c = gc \c' -> method3Eff s c' a b c


foreign import method4Impl :: forall o a b c e ret. Fn6 String o a b c e ret

method4            = runFn6 method4Impl
method4C s a b c d = gc \c' -> method4 s c' a b c d

foreign import method4EffImpl :: forall o a b c e f eff. Fn6 String o a b c e (Eff eff f)

method4Eff            = runFn6 method4EffImpl
method4EffC s a b c d = gc \c' -> method4Eff s c' a b c d


foreign import method5Impl :: forall o a b c e f ret. Fn7 String o a b c e f ret

method5              = runFn7 method5Impl
method5C s a b c d e = gc \c' -> method5 s c' a b c d e

foreign import method5EffImpl :: forall o a b c e f g eff. Fn7 String o a b c e f (Eff eff g)

method5Eff              = runFn7 method5EffImpl
method5EffC s a b c d e = gc \c' -> method5Eff s c' a b c d e


foreign import getterImpl :: forall o a eff. Fn2 String o (Eff eff a)

getter    = runFn2 getterImpl
getterC s = gc \c -> getter s c


foreign import modifierImpl :: forall o a b eff. Fn3 String o (a -> b) (Eff eff b)

modifier      = runFn3 modifierImpl
modifierC s f = gc \c -> modifier s c f


foreign import setterImpl :: forall o v eff. Fn3 String o v (Eff eff v)

setter      = runFn3 setterImpl
setterC s v = gc \c -> setter s c v


foreign import instantiate0FromImpl :: forall a o e. Fn2 String o (Eff e a)

instantiate0From = runFn2 instantiate0FromImpl

instantiate0 :: forall a e. String -> Eff e a
instantiate0 s = getContext >>= instantiate0From s

foreign import instantiate1FromImpl :: forall a b o e. Fn3 String o a (Eff e b)

instantiate1From = runFn3 instantiate1FromImpl

instantiate1 :: forall a b e. String -> a -> Eff e b
instantiate1 s a = getContext >>= \c -> instantiate1From s c a

foreign import instantiate2FromImpl :: forall a b c o e. Fn4 String o a b (Eff e c)

instantiate2From = runFn4 instantiate2FromImpl

instantiate2 :: forall a b c e. String -> a -> b -> Eff e c
instantiate2 s a b = getContext >>= \c -> instantiate2From s c a b

foreign import instantiate3FromImpl :: forall a b c d o e. Fn5 String o a b c (Eff e d)

instantiate3From = runFn5 instantiate3FromImpl

instantiate3 :: forall a b c d e. String -> a -> b -> c -> Eff e d
instantiate3 s a b c = getContext >>= \c' -> instantiate3From s c' a b c

foreign import instantiate4FromImpl :: forall a b c d e f o. Fn6 String o a b c d (Eff e f)

instantiate4From = runFn6 instantiate4FromImpl

instantiate4 :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
instantiate4 s a b c d = getContext >>= \c' -> instantiate4From s c' a b c d

foreign import instantiate5FromImpl :: forall a b c d e f g o. Fn7 String o a b c d f (Eff e g)

instantiate5From = runFn7 instantiate5FromImpl

instantiate5 :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
instantiate5 s a b c d e = getContext >>= \c' -> instantiate5From s c' a b c d e
