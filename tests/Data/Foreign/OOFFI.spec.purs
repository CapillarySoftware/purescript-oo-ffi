module Data.Foreign.OOFFI.Spec where

import Data.Foreign.OOFFI
import Debug.Trace
import Test.Mocha
import Test.Chai
import Test.QuickCheck
import Control.Monad.Eff
import Control.Monad.Eff.Random

foreign import data TestObj :: *
foreign import data OOTest  :: !

foreign import obj """
  var c = PS.Context.getContext();
  c.i0 = function(               ){ this.x = true;              };
  c.i1 = function(             x ){ this.x = x;                 };
  c.i2 = function(          x, y ){ this.x = x + y;             };
  c.i3 = function(       x, y, z ){ this.x = x + y / z;         };
  c.i4 = function(    w, x, y, z ){ this.x = w * x + y / z;     };
  c.i5 = function( v, w, x, y, z ){ this.x = v * w + x / y - z; };

  var obj = {
    method0    : function(               ){ return true;              },
    method0Eff : function(               ){ return true;              },
    method1    : function( n             ){ return n;                 },
    method1Eff : function( n             ){ return n;                 },
    method2    : function( x, y          ){ return x + y;             },
    method2Eff : function( x, y          ){ return x + y;             },
    method3    : function( x, y, z       ){ return x * y / z;         },
    method3Eff : function( x, y, z       ){ return x * y / z;         },
    method4    : function( w, x, y, z    ){ return w * x / y + z;     },
    method4Eff : function( w, x, y, z    ){ return w * x / y + z;     },
    method5    : function( v, w, x, y, z ){ return v - w * x / y + z; },
    method5Eff : function( v, w, x, y, z ){ return v - w * x / y + z; },
    getter     : false,
    modifier   : false,
    setter     : false
  };""" :: TestObj

type Effit ret = forall e. Eff (ooTest :: OOTest | e) ret

spec = describe "OOFFI" do

  it "method0"    let m0 =  method0 "method0"       obj :: Boolean
                  in expect m0  `toEqual` true
  
  it "method0Eff" do m0M <- method0Eff "method0Eff" obj :: Effit Boolean
                     expect m0M `toEqual` true

  it "method1" $ quickCheck \x -> 
    x == method1 "method1" obj x :: Number

  it "method1Eff" do n     <- random

                     m1Eff <- method1Eff "method1Eff" obj n :: Effit Number
                     expect m1Eff `toEqual` n

  it "method2" $ quickCheck \x y ->
    x + y == method2 "method2" obj x y :: Number

  it "method2Eff" do x     <- random
                     y     <- random

                     m2Eff <- method2Eff "method2Eff" obj x y :: Effit Number
                     expect m2Eff `toEqual` (x + y)

  it "method3" $ quickCheck \x y z ->
    x * y / z == method3 "method3" obj x y z :: Number

  it "method3Eff" do x     <- random
                     y     <- random
                     z     <- random

                     m3Eff <- method3Eff "method3Eff" obj x y z :: Effit Number
                     expect m3Eff `toEqual` (x * y / z)

  it "method4" $ quickCheck \w x y z ->
    w * x / y + z == method4 "method4" obj w x y z :: Number

  it "method4Eff" do w     <- random
                     x     <- random
                     y     <- random
                     z     <- random

                     m4Eff <- method4Eff "method4Eff" obj w x y z :: Effit Number
                     expect m4Eff `toEqual` (w * x / y + z)

  it "method5" $ quickCheck \v w x y z ->
    v - w * x / y + z == method5 "method5" obj v w x y z :: Number

  it "method5Eff" do v     <- random
                     w     <- random
                     x     <- random
                     y     <- random
                     z     <- random

                     m5Eff <- method5Eff "method5Eff" obj v w x y z :: Effit Number
                     expect m5Eff `toEqual` (v - w * x / y + z)


  it "getter" do g <- getter "getter" obj :: Effit Boolean
                 expect g `toEqual` false

  it "modifier" do foo <- modifier "modifier" obj (const true) :: Effit Boolean
                   expect foo `toEqual` true

  it "setter" do foo <- setter "setter" obj true :: Effit Boolean
                 expect foo `toEqual` true

  it "get set" do x  <- random
                  x' <- random

                  _  <- setter   "foo" obj x
                  g  <- getter   "foo" obj :: Effit Boolean
                  
                  expect x `toEqual` g

                  _  <- modifier "foo" obj \_ -> x'
                  g' <- getter   "foo" obj
                  
                  expect x' `toEqual` g'

  it "instanciate0" do x <- instantiate0 "i0"
                       expect x.x `toEqual` true

  it "instantiate1" do r <- random
                       
                       x <- instantiate1 "i1" r
                       expect x.x `toEqual` r

  it "instantiate2" do r  <- random
                       r' <- random
                       
                       x  <- instantiate2 "i2" r r'
                       expect x.x `toEqual` (r + r')

  it "instantiate3" do r   <- random
                       r'  <- random
                       r'' <- random

                       x   <- instantiate3 "i3" r r' r''
                       expect x.x `toEqual` (r + r' / r'')


  it "instantiate4" do r    <- random
                       r'   <- random
                       r''  <- random
                       r''' <- random

                       x    <- instantiate4 "i4" r r' r'' r'''
                       expect x.x `toEqual` (r * r' + r'' / r''')

  it "instantiate5" do r     <- random
                       r'    <- random
                       r''   <- random
                       r'''  <- random
                       r'''' <- random

                       x     <- instantiate5 "i5" r r' r'' r''' r''''
                       expect x.x `toEqual` (r * r' + r'' / r''' - r'''')