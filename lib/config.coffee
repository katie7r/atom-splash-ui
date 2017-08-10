# based on isotope-ui + accents-ui:

module.exports =

  apply: () ->

    body = document.querySelector('body')

    defaultSplash = '#ADB5BD' # oc-gray-5
    # defaultSplash = '#15AABF' # oc-cyan-6

    # helper functions

    getConfig = (config) -> atom.config.get("splash-ui.#{config}")
    setConfig = (config, value) -> atom.config.set("splash-ui.#{config}", value)

    isHex = (hex) ->
      true if (hex.match /^#([\da-fA-F]{3})$/) or (hex.match /^#([\da-fA-F]{6})$/)

    # functions

    applySplashColor = (color) ->
      if isHex(color)
        console.log('isHex')
        fs = require 'fs'
        path = require 'path'
        writePath = path.join __dirname, '..', 'styles/ui-splash.less'
        fs.writeFileSync writePath, "@splash-color: #{color};\n"
      else
        console.log('notHex')

    # applySyntaxSetting = () ->
    #   body.setAttribute('data-ui-use-syntax-theme', getConfig('useSyntaxTheme'))

    # run when atom is ready

    applySplashColor(getConfig('splashColor'))
    # applySyntaxSetting()

    # run when configs change

    atom.config.onDidChange 'splash-ui.addSplashColor', ->
      addSplashColor = getConfig('addSplashColor')
      color = if addSplashColor then getConfig('splashColor') else defaultSplash # TODO how to programmatically reset to default?
      applySplashColor(color)

    atom.config.onDidChange 'splash-ui.splashColor', ->
      color = getConfig('splashColor') ? defaultSplash # TODO how to programmatically reset to default?
      if getConfig('addSplashColor')
        applySplashColor(color)

    # atom.config.onDidChange 'splash-ui.useSyntaxTheme', ->
    #   applySyntaxSetting()


    # # TODO color picker?
    #
    # rgbToHex = (r, g, b) ->
    #   '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)
    #
    # hexToRgb = (hex) ->
    #   shorthand = /^#?([a-f\d]{1})([a-f\d]{1})([a-f\d]{1})$/i.exec(hex)
    #   if shorthand
    #     r = shorthand[1]
    #     g = shorthand[2]
    #     b = shorthand[3]
    #     hex = "##{r}#{r}#{g}#{g}#{b}#{b}"
    #
    #   result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    #   if result
    #       r: parseInt(result[1], 16),
    #       g: parseInt(result[2], 16),
    #       b: parseInt(result[3], 16),
    #   else
    #       null
    #
    # applySplashColor = (rgb) ->
    #   hex = rgbToHex(rgb.red, rgb.green, rgb.blue)
    #   if isHex(hex)
    #     fs = require 'fs'
    #     path = require 'path'
    #     writePath = path.join __dirname, '..', 'styles/ui-splash.less'
    #     fs.writeFileSync writePath, "@splash-color: #{hex};\n"
    #
    # atom.config.onDidChange 'splash-ui.splashColor', ->
    #   hex = getConfig('splashColor') ? '#15AABF' # TODO how to programmatically reset to default?
    #   rgb = rgbToHex(hex)
    #   console.log('color', hex, rgb)
    #   applySplashColor(rgb)
    #
    # atom.config.onDidChange 'splash-ui.splashColorPicker', ->
    #   console.log(getConfig('splashColorPicker'))
    #
    # atom.config.onDidChange 'splash-ui.splashColorHex', ->
    #   color = getConfig('splashColor')
    #   hex = getConfig('splashColorHex')
    #   rgb = hexToRgb(hex)
    #
    #   if rgb
    #     color.red = rgb.r
    #     color.green = rgb.g
    #     color.blue = rgb.b
    #     console.log('hex -> rgb', hex, '->', rgb)
    #     setConfig('splashColor', color)
    #
    # atom.config.onDidChange 'splash-ui.splashColor', ->
    #   color = getConfig('splashColor')
    #   console.log('color', color)
    #   applySplashColor(color)
    #   setConfig('splashColorHex', rgbToHex(color.red, color.green, color.blue))
