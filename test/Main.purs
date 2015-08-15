module Test.Main where

import Prelude

import Control.Apply              ((*>))
import Control.Monad.Aff          (Aff()) -- MonadEff Aff
import Control.Monad.Eff.Console  (CONSOLE(), log)
import Control.Monad.Eff          (Eff())
import Control.Monad.Eff.Class    (liftEff)
import Control.Monad.Eff.Random   (RANDOM(), random, randomBool)
import Foreign.Context            (Context(), getContext)
import Test.Spec                  (describe, it)
import Test.Spec.Assertions       (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner           (Process(), run)
import Test.Spec.QuickCheck       (quickCheck)

import Data.Foreign.OOFFI

foreign import data TestObj :: *
foreign import data OOTEST :: !

foreign import obj :: TestObj
foreign import assignContext :: forall eff. Context -> Eff eff Unit

type Effit ret = Eff (ooTest :: OOTEST, random :: RANDOM, console :: CONSOLE, process :: Process) ret
type Affit ret = Aff (ooTest :: OOTEST, random :: RANDOM, console :: CONSOLE, process :: Process) ret

lift' :: forall a. Effit a -> Affit a
lift' = liftEff

main = (getContext >>= assignContext) *> run [consoleReporter] do
  describe "OOFFI" do
    describe "the method functions" do
      it "method0" do
        method0 "method0" obj `shouldEqual` true
      it "method0Eff" do
        x <- lift' (method0Eff "method0Eff" obj) :: Affit Boolean
        x `shouldEqual` true
      it "method1" do
        quickCheck \x -> x == method1 "method1" obj x :: Number
      it "method1Eff" do
        n <- lift' random :: Affit Number
        x <- lift' (method1Eff "method1Eff" obj n)
        x `shouldEqual` n
      it "method2" do
        quickCheck \x y -> x + y == method2 "method2" obj x y :: Number
      it "method2Eff" do
        n <- lift' random :: Affit Number
        m <- lift' random
        x <- lift' (method2Eff "method2Eff" obj n m)
        x `shouldEqual` (n + m)
      it "method3" do
        quickCheck \x y z -> x * y / z == method3 "method3" obj x y z :: Number
      it "method3Eff" do
        n  <- lift' random :: Affit Number
        n1 <- lift' random
        n2 <- lift' random
        x  <- lift' (method3Eff "method3Eff" obj n n1 n2)
        x `shouldEqual` (n * n1 / n2)
      it "method4" do
        quickCheck \w x y z -> w * x / y + z == method4 "method4" obj w x y z :: Number
      it "method4Eff" do
        n  <- lift' random :: Affit Number
        n1 <- lift' random
        n2 <- lift' random
        n3 <- lift' random
        x  <- lift' (method4Eff "method4Eff" obj n n1 n2 n3)
        x `shouldEqual` (n * n1 / n2 + n3)
      it "method5" do
        quickCheck \v w x y z -> v - w * x / y + z == method5 "method5" obj v w x y z :: Number
      it "method5Eff" do
        n  <- lift' random :: Affit Number
        n1 <- lift' random
        n2 <- lift' random
        n3 <- lift' random
        n4 <- lift' random
        x  <- lift' (method5Eff "method5Eff" obj n n1 n2 n3 n4)
        x `shouldEqual` (n - n1 * n2 / n3 + n4)


    describe "the property access functions" do
      it "getter" do
        g <- lift' (getter "getter" obj) :: Affit Boolean
        g `shouldEqual` false
      it "modifier" do
        foo <- lift' (modifier "modifier" obj (const true)) :: Affit Boolean
        foo `shouldEqual` true
      it "setter" do
        foo <- lift' (setter "setter" obj true) :: Affit Boolean
        foo `shouldEqual` true
      it "get set" do
        x  <- lift' randomBool :: Affit Boolean
        x' <- lift' randomBool
        _  <- lift' (setter "foo" obj x)
        g  <- lift' (getter "foo" obj)
        x `shouldEqual` g
        _  <- lift' (modifier "foo" obj \_ -> x')
        g' <- lift' (getter   "foo" obj)
        x' `shouldEqual` g'


    describe "the instantiator functions" do
      it "instantiate0" do
        x <- lift' (instantiate0 "i0") :: forall r. Affit {x :: Boolean | r}
        x.x `shouldEqual` true
      it "instantiate1" do
        r <- lift' random :: Affit Number
        x <- lift' (instantiate1 "i1" r)
        x.x `shouldEqual` r
      it "instantiate2" do
        r  <- lift' random :: Affit Number
        r' <- lift' random
        x  <- lift' (instantiate2 "i2" r r')
        x.x `shouldEqual` (r + r')
      it "instantiate3" do
        r  <- lift' random :: Affit Number
        r1 <- lift' random
        r2 <- lift' random
        x  <- lift' (instantiate3 "i3" r r1 r2)
        x.x `shouldEqual` (r + r1 / r2)
      it "instantiate4" do
        r  <- lift' random :: Affit Number
        r1 <- lift' random
        r2 <- lift' random
        r3 <- lift' random
        x  <- lift' (instantiate4 "i4" r r1 r2 r3)
        x.x `shouldEqual` (r * r1 + r2 / r3)
      it "instantiate5" do
        r  <- lift' random :: Affit Number
        r1 <- lift' random
        r2 <- lift' random
        r3 <- lift' random
        r4 <- lift' random
        x  <- lift' (instantiate5 "i5" r r1 r2 r3 r4)
        x.x `shouldEqual` (r * r1 + r2 / r3 - r4)
