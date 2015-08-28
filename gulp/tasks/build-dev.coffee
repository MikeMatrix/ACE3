config = require '../configuration.coffee'

_ = require 'underscore'
fs = require 'fs'
path = require 'path'
del = require 'del'
merge = require 'merge-stream'

gulp = require 'gulp'
gutil = require 'gulp-util'
newer = require 'gulp-newer'
debug = require 'gulp-debug'
foreach = require 'gulp-foreach'
shell = require 'gulp-shell'
tap = require 'gulp-tap'

# Let NodeJS know a lot is being run simultanious
process.stdout.setMaxListeners(0)
process.stdin.setMaxListeners(0)

# Don't log when silent
gutil.log = gutil.noop if gutil.env.silent

# Get all folders in a directory
getFolders = (dir) ->
    fs.readdirSync dir
    .filter (file) ->
        fs.statSync(path.join(dir, file)).isDirectory()

# Get all PBO files in a directory
getPBOs = (dir) ->
    fs.readdirSync dir
    .filter (file) ->
        fs.statSync(path.join(dir, file)).isFile() && path.extname(file) == ".pbo"

gulp.task 'build-dev', "Build development files", ['build-dev-purge-obsolete', 'build-dev-build']

# Delete all obsolete PBOs that don't have a matching module folder
gulp.task 'build-dev-purge-obsolete', "Delete all obsolete development PBOs that don't have a matching module folder.", (callback) ->
    addons = getFolders config.addons
    addonFiles = getPBOs(config.addons).map (file) ->
        file.replace new RegExp("#{config.prefix}_(.*)\.pbo"), "$1"

    obsolete = _.difference(addonFiles, addons).map (moduleName) ->
        path.resolve config.addons, "#{config.prefix}_#{moduleName}.pbo"

    del obsolete, force: true, (err, paths) ->
        return callback(err) if paths.length <= 0
        paths.map (path) ->
            gutil.log "Delted obsolete", gutil.colors.cyan(path)
        callback(err)

# Delete all PBOs
gulp.task 'build-dev-clean', "Delete all development PBOs.", (callback) ->
    addonFiles = getPBOs(config.addons).map (file) ->
        path.resolve config.addons, file
    del addonFiles, force: true, (err, paths) ->
        return callback(err) if paths.length <= 0
        paths.map (path) ->
            gutil.log "Deleted", gutil.colors.cyan(path)
        callback(err)

# Build all PBOs that have changed
gulp.task 'build-dev-build', "Build all changed development PBOs.", ['build-dev-purge-obsolete'], ->
    modules = getFolders config.addons

    tasks = modules.map (addon) ->
        gulp.src path.join(config.addons, addon), read: false
        .pipe if gutil.env.rebuild then gutil.noop() else newer(path.join(config.addons, "ace_#{addon}.pbo"))
        .pipe shell "makepbo -NUP -@=#{config.mainPrefix}\\#{config.prefix}\\addons\\#{addon} \"<%= file.path %>\" \"#{path.join config.addons, "#{config.prefix}_#{addon}.pbo"}\"", quiet: true
        .pipe tap (file, t) ->
            gutil.log "Finished building", gutil.colors.cyan(file.path), "=>", gutil.colors.cyan("#{path.join config.addons, "#{config.prefix}_#{addon}.pbo"}")

    merge tasks
