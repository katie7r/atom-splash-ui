module.exports =

  config:
    splashColor:
        description: 'Set a color that will splash across the theme'
        type: 'color'
        default: '#F8F9FA' # @oc-gray-0
    hexColor:
        description: 'Set an splash color by hex value (cannot be shorthand, use #rrggbb)'
        type: 'string'
        default: '#F8F9FA' # @oc-gray-0
    # fontSize:
    #     description: 'Set the global font size for this theme. A bit finicky at the moment, can sometimes take a few reloads to see changes.'
    #     type: 'integer'
    #     default: 12
    #     minimum: 8
    #     maximum: 24
    useSyntax:
        description: 'Override the gutter, background, and selection colours'
        type: 'boolean'
        default: 'true'
    debugMode:
        description: 'Log certain details to the console'
        type: 'boolean'
        default: 'false'

  activate: (state) ->
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
