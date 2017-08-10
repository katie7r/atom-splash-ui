# based on isotope-ui + accents-ui:

module.exports =

  config:

    addSplashColor:
      description: 'Add a splash of color to the UI.'
      type: 'boolean'
      default: false

    splashColor:
      description: 'Choose your splash of color.'
      type: 'string'
      default: '#ADB5BD' # cyan-6: #15AABF; gray-5: #ADB5BD

    # splashColorPicker:
    #   description: 'Choose your splash of color.'
    #   type: 'color'
    #   default: '#15AABF' # cyan-6: rgb(21,170,191); gray-5: rgb(173,181,189)
    #
    # splashColorHex:
    #   description: 'Enter the hexcode for your splash of color.'
    #   type: 'string'
    #   default: '#15AABF' # cyan-6: #15AABF; gray-5: #ADB5BD

    # useSyntaxTheme:
    #   description: 'Overwrite default UI colors with those from the syntax theme'
    #   type: 'boolean'
    #   default: false

  activate: (state) ->
    # code in separate file so deferral keeps activation time down
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
