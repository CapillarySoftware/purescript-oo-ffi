module Data.Foreign.OOFFI.Spec where

import Data.Foreign.OOFFI
import Debug.Trace
import Test.Mocha
import Test.Chai
import Control.Monad.Eff

foreign import data TestObj :: *
foreign import data OOTest  :: !

foreign import obj
  "var obj = {\
  \    method0    : function(){              return true; },\
  \    method0Eff : function(){              return true; },\
  \    method1    : function(n){             return n; },\
  \    method1Eff : function(n){             return n; },\
  \    method2    : function(x, y){          return x + y; },\
  \    method2Eff : function(x, y){          return x + y; },\
  \    method3    : function(x, y, z){       return x * y / z; },\
  \    method3Eff : function(x, y, z){       return x * y / z; },\
  \    method4    : function(w, x, y, z){    return w * x / y + z; },\
  \    method4Eff : function(w, x, y, z){    return w * x / y + z; },\
  \    method5    : function(v, w, x, y, z){ return v - w * x / y + z; },\
  \    method5Eff : function(v, w, x, y, z){ return v - w * x / y + z; },\
  \    getter     : false,\
  \    modifier   : false,\
  \    setter     : false\
  \ }" :: TestObj

type Effit ret = forall e. Eff (ooTest :: OOTest | e) ret

spec = describe "OOFFI" $ do

  describe "methods" $ do

    it "method0" $ let
        m0 = method0 "method0" obj :: Boolean
      in expect m0 `toEqual` true

    it "method0Eff" $ do
      m0M <- method0Eff "method0Eff" obj :: Effit Boolean
      expect m0M `toEqual` true

    it "method1" $ let
        n  = 3
        m1 = method1 "method1" obj :: Number -> Number
      in expect (m1 n) `toEqual` n

    it "method1Eff" $ do
      let n = 3
      m1Eff <- method1Eff "method1Eff" obj n :: Effit Number
      expect m1Eff `toEqual` n

    it "method2" $ let
        x  = 3
        y  = 4
        m2 = method2 "method2" obj x y :: Boolean
      in expect m2 `toEqual` (x + y)

    it "method2Eff" $ do
      let x = 4
          y = 7
      m2Eff <- method2Eff "method2Eff" obj x y :: Effit Number
      expect m2Eff `toEqual` (x + y)

    it "method3" $ let
        x  = 3
        y  = 8
        z  = 5
        m3 = method3 "method3" obj x y z :: Number
      in expect m3 `toEqual` (x * y / z)

    it "method3Eff" $ do
      let x = 5
          y = 2
          z = 9
      m3Eff <- method3Eff "method3Eff" obj x y z :: Effit Number
      expect m3Eff `toEqual` (x * y / z)

    it "method4" $ let
        w  = 2
        x  = 3
        y  = 9
        z  = 4
        m4 = method4 "method4" obj w x y z :: Number
      in expect m4 `toEqual` (w * x / y + z)

    it "method4Eff" $ do
      let w = 4
          x = 8
          y = 3
          z = 2
      m4Eff <- method4Eff "method4Eff" obj w x y z :: Effit Number
      expect m4Eff `toEqual` (w * x / y + z)

    it "method5" $ let
        v  = 4
        w  = 6
        x  = 8
        y  = 3
        z  = 2
        m5 = method5 "method5" obj v w x y z :: Number
      in expect m5 `toEqual` (v - w * x / y + z)

    it "method5Eff" $ do
      let v = 3
          w = 4
          x = 5
          y = 7
          z = 9
      m5Eff <- method5Eff "method5Eff" obj v w x y z :: Effit Number
      expect m5Eff `toEqual` (v - w * x / y + z)


  it "getter" $ do
    g <- getter "getter" obj :: Effit Boolean
    expect g `toEqual` false

  it "modifier" $ do
    foo <- modifier "modifier" obj (const true) :: Effit Boolean
    expect foo `toEqual` true

  it "setter" $ do
    foo <- setter "setter" obj true :: Effit Boolean
    expect foo `toEqual` true


