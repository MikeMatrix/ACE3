path = require 'path'

module.exports =
    # Directory layout
    root: path.resolve '..'
    addons: path.resolve '../addons'
    optionals: path.resolve '../optionals'
    release: path.resolve '../release'

    # Project Values
    mainPrefix: 'z'
    prefix: 'ace'
