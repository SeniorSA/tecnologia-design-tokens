const gulp = require('gulp');
const cleanCSS = require('gulp-clean-css');
const rename = require('gulp-rename');
const fs = require('fs');

gulp.task('minify-css', () =>
  gulp
    .src('dist/web/css/**/*.css')
    .pipe(
      cleanCSS({}, details => {
        console.log(`${details.name}: originalSize: ${details.stats.originalSize} - reduced to ${details.stats.minifiedSize}`);
      }),
    )
    .pipe(
      rename({
        suffix: '.min',
        extname: '.css',
      }),
    )
    .pipe(gulp.dest('dist/web/css/', {})),
);

gulp.task('copy-scss-files', () => gulp.src('./web/scss/**').pipe(gulp.dest('dist/web/scss')));

gulp.task('clean', done => {
  fs.rmdirSync('dist', { recursive: true });
  return done();
});

gulp.task('default', gulp.series(['minify-css', 'copy-scss-files']));
