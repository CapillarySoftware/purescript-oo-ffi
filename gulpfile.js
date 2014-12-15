var 

gulp       = require('gulp'),
purescript = require('gulp-purescript'),
concat     = require('gulp-concat'),
gulpif     = require('gulp-if'),
gulpFilter = require('gulp-filter'),
express    = require('express'),
runSq      = require('run-sequence'),
karma      = require('gulp-karma'),
mocha      = require('gulp-mocha')(),

paths      = {
  src : {
    src : [
      "bower_components/purescript-*/src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs.hs",
      "src/**/*.purs"
    ],
    dest : "lib"
  },
  test : {
    src : [
      "bower_components/chai/chai.js",
      "bower_components/js-yaml/dist/js-yaml.js",
      "bower_components/purescript-*/src/**/*.purs",
      "bower_components/purescript-*/src/**/*.purs.hs",
      "src/**/*.purs",
      "tests/**/*.purs"
    ],
    dest : 'tmp'
  }
},

options    = {
  src :{
    output : 'Presentable.js'
  },
  test :{
    output : 'Test.js',
    main : true,
    runtimeTypeChecks : false,
    externs : "extern.purs"
  }
},

port       = 3333,
server     = express(),

build = function(k){
  return function(){

    var x   = paths[k],
        o   = options[k],
        psc = purescript.psc(o);


      psc.on('error', function(e){
        console.error(e.message);
        psc.end();  
      });

      return gulp.src(x.src)
        .pipe(gulpif(/purs/,  psc))
        .pipe(concat(o.output))
        .pipe( gulp.dest(x.dest));
 
  };
}; // var

gulp.task('build:test',    build('test'));
gulp.task('build:src',     build('src'));

gulp.task('test:unit', function(){
  gulp.src(options.test.output)
    .pipe(karma({
      configFile : "./tests/karma.conf.js",
      noColors   : true,
      action     : "run"
    }));
  gulp.src(paths.test.dest+"/"+options.test.output).pipe(mocha);
});

gulp.task('doc', function(){
  gulp.src("src/**/*.purs")
    .pipe(purescript.docgen())
    .pipe( gulp.dest("README.md"));
});

gulp.task('default', ['build:src']);
gulp.task('test',    function(){ runSq('build:test','test:unit'); });