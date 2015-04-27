var path = require('path');
var gulp = require('gulp');
var config = require('../config');
var browserSync = require('browser-sync');

gulp.task('markup', function() {
  return gulp.src(config.markup.src)
    .pipe(gulp.dest(config.markup.dest))
    .pipe(browserSync.reload({
      stream: true
    }));
});
