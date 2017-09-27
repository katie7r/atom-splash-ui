module.exports =

  config:
    useSplash:
        description: 'Add a splash of color to the theme'
        type: 'boolean'
        default: 'false'
    splashColor:
        description: 'Set a splash color by hex value'
        type: 'string'
        default: '#66D9E8' # @oc-cyan-3
    useSyntax:
        description: 'Override the UI background and text colors with those from selected syntax theme'
        type: 'boolean'
        default: 'false'

  activate: (state) ->
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
