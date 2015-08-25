gulp = require 'gulp'
fs = require 'fs'
path = require 'path'

getFolders = (dir) ->
    fs.readdirSync dir
    .filter (file) ->
        fs.statSync path.join(dir, file)
        .isDirectory()

gulp.task 'build-dev', []

gulp.task 'purge-obsolete', ->
    addons = getFolders './addons'

    tasks = addons.map (folder) ->
        
