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
  , instantiate5, instantiate5From
  ) where

import Prelude

import Control.Bind      ((<=<))
import Control.Monad.Eff (Eff())
import Data.Function     -- runFnX
import Foreign.Context   (getContext)

-- Helper Functions -----------------------------------------------------------

-- Unsafe Foreign Imports
foreign import instantiateImpl :: forall c fn ret eff. c -> fn (Eff eff ret)
foreign import mapEff          :: forall fn ret eff. fn ret -> fn (Eff eff ret)
foreign import unsafeGetter    :: forall o a. String -> o -> a

(..) :: forall a b c d. (c -> d) -> (a -> b -> c) -> a -> b -> d
(..) f g a b = f (g a b)

-- Property Access ------------------------------------------------------------

-- Safe Foreign Imports
foreign import getter   :: forall o a eff. String -> o -> Eff eff a
foreign import modifier :: forall o a b eff. String -> o -> (a -> b) -> Eff eff b
foreign import setter   :: forall o a eff. String -> o -> a -> Eff eff a

getterC :: forall a eff. String -> Eff eff a
getterC p = getContext >>= getter p

modifierC :: forall a b eff. String -> (a -> b) -> Eff eff b
modifierC p f = getContext >>= \c -> modifier p c f

setterC :: forall a eff. String -> a -> Eff eff a
setterC p x = getContext >>= \c -> setter p c x


-- Methods --------------------------------------------------------------------

-- 0 Argument -----------------------------------------------------------------
method0 :: forall o a. String -> o -> a
method0 = runFn0 .. unsafeGetter

method0C :: forall a eff. String -> Eff eff a
method0C p = method0 p <$> getContext

method0Eff :: forall o a eff. String -> o -> Eff eff a
method0Eff = (runFn0 <<< mapEff) .. unsafeGetter

method0EffC :: forall a eff. String -> Eff eff a
method0EffC p = getContext >>= method0Eff p

-- 1 Argument -----------------------------------------------------------------
method1 :: forall o a b. String -> o -> a -> b
method1 = runFn1 .. unsafeGetter

method1C :: forall a b eff. String -> a -> Eff eff b
method1C p a = (\o -> method1 p o a) <$> getContext

method1Eff :: forall o a b eff. String -> o -> a -> Eff eff b
method1Eff = (runFn1 <<< mapEff) .. unsafeGetter

method1EffC :: forall a b eff. String -> a -> Eff eff b
method1EffC p a = getContext >>= \o -> method1Eff p o a

-- 2 Argument -----------------------------------------------------------------
method2 :: forall o a b c. String -> o -> a -> b -> c
method2 = runFn2 .. unsafeGetter

method2C :: forall a b c eff. String -> a -> b -> Eff eff c
method2C p a b = (\o -> method2 p o a b) <$> getContext

method2Eff :: forall o a b c eff. String -> o -> a -> b -> Eff eff c
method2Eff = (runFn2 <<< mapEff) .. unsafeGetter

method2EffC :: forall a b c eff. String -> a -> b -> Eff eff c
method2EffC p a b = getContext >>= \o -> method2Eff p o a b

-- 3 Argument -----------------------------------------------------------------
method3 :: forall o a b c d. String -> o -> a -> b -> c -> d
method3 = runFn3 .. unsafeGetter

method3C :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
method3C p a b c = (\o -> method3 p o a b c) <$> getContext

method3Eff :: forall o a b c d eff. String -> o -> a -> b -> c -> Eff eff d
method3Eff = (runFn3 <<< mapEff) .. unsafeGetter

method3EffC :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
method3EffC p a b c = getContext >>= \o -> method3Eff p o a b c

-- 4 Argument -----------------------------------------------------------------
method4 :: forall o a b c d e. String -> o -> a -> b -> c -> d -> e
method4 = runFn4 .. unsafeGetter

method4C :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
method4C p a b c d = (\o -> method4 p o a b c d) <$> getContext

method4Eff :: forall o a b c d e eff. String -> o -> a -> b -> c -> d -> Eff eff e
method4Eff = (runFn4 <<< mapEff) .. unsafeGetter

method4EffC :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
method4EffC p a b c d = getContext >>= \o -> method4Eff p o a b c d

-- 5 Argument -----------------------------------------------------------------
method5 :: forall o a b c d e f. String -> o -> a -> b -> c -> d -> e -> f
method5 = runFn5 .. unsafeGetter

method5C :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
method5C p a b c d e = (\o -> method5 p o a b c d e) <$> getContext

method5Eff :: forall o a b c d e f eff. String -> o -> a -> b -> c -> d -> e -> Eff eff f
method5Eff = (runFn5 <<< mapEff) .. unsafeGetter

method5EffC :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
method5EffC p a b c d e = getContext >>= \o -> method5Eff p o a b c d e


-- Instantiators --------------------------------------------------------------

-- 0 Argument -----------------------------------------------------------------
instantiate0From :: forall o a eff. String -> o -> Eff eff a
instantiate0From = (runFn0 <<< instantiateImpl) .. unsafeGetter

instantiate0 :: forall a eff. String -> Eff eff a
instantiate0 p = getContext >>= instantiate0From p

-- 1 Argument -----------------------------------------------------------------
instantiate1From :: forall o a b eff. String -> o -> a -> Eff eff b
instantiate1From = (runFn1 <<< instantiateImpl) .. unsafeGetter

instantiate1 :: forall a b eff. String -> a -> Eff eff b
instantiate1 p a = getContext >>= \o -> instantiate1From p o a

-- 2 Argument -----------------------------------------------------------------
instantiate2From :: forall o a b c eff. String -> o -> a -> b -> Eff eff c
instantiate2From = (runFn2 <<< instantiateImpl) .. unsafeGetter

instantiate2 :: forall a b c eff. String -> a -> b -> Eff eff c
instantiate2 p a b = getContext >>= \o -> instantiate2From p o a b

-- 3 Argument -----------------------------------------------------------------
instantiate3From :: forall o a b c d eff. String -> o -> a -> b -> c -> Eff eff d
instantiate3From = (runFn3 <<< instantiateImpl) .. unsafeGetter

instantiate3 :: forall a b c d eff. String -> a -> b -> c -> Eff eff d
instantiate3 p a b c = getContext >>= \o -> instantiate3From p o a b c

-- 4 Argument -----------------------------------------------------------------
instantiate4From :: forall o a b c d e eff. String -> o -> a -> b -> c -> d -> Eff eff e
instantiate4From = (runFn4 <<< instantiateImpl) .. unsafeGetter

instantiate4 :: forall a b c d e eff. String -> a -> b -> c -> d -> Eff eff e
instantiate4 p a b c d = getContext >>= \o -> instantiate4From p o a b c d

-- 5 Argument -----------------------------------------------------------------
instantiate5From :: forall o a b c d e f eff. String -> o -> a -> b -> c -> d -> e -> Eff eff f
instantiate5From = (runFn5 <<< instantiateImpl) .. unsafeGetter

instantiate5 :: forall a b c d e f eff. String -> a -> b -> c -> d -> e -> Eff eff f
instantiate5 p a b c d e = getContext >>= \o -> instantiate5From p o a b c d e
