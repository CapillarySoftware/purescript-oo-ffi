/* global exports */
"use strict";

// module Test.Main

exports.assignContext = function(ctx) {
  return function() {
    ctx.i0 = function(               ){ this.x = true;              };
    ctx.i1 = function(             x ){ this.x = x;                 };
    ctx.i2 = function(          x, y ){ this.x = x + y;             };
    ctx.i3 = function(       x, y, z ){ this.x = x + y / z;         };
    ctx.i4 = function(    w, x, y, z ){ this.x = w * x + y / z;     };
    ctx.i5 = function( v, w, x, y, z ){ this.x = v * w + x / y - z; };
  }
}

exports.obj = {
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
}
