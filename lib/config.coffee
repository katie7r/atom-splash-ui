module.exports =

# more reliable rgb to hex conversion
# .toHexString function sometimes returns shorthand
rgbToHex = (r, g, b) ->
    '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)

# converts hex to rgb
hexToRgb = (hex) ->
    result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if result
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16),
    else
        null

# returns true if matches hex pattern
checkHex = (hex) ->
    reg = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/
    str = hex
    true if str.match reg

# string splash, writes hex colour to file
setSplash = (splash) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-splash.less'
    fs.writeFileSync writePath, "@splash-color: #{rgbToHex(splash.red, splash.green, splash.blue)};\n"

# bool trigger, specifies whether or not to override syntax
setSyntax = (trigger) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-syntax-include.less'
    content = if trigger then '@import "ui-syntax";\n' else '\n'
    fs.writeFileSync writePath, content

# shortens atom.config.get methods for redundancy
getOption = (option) ->
    switch option
        when 'splashColor' then atom.config.get('splash-ui.splashColor')
        when 'hexColor' then atom.config.get('splash-ui.hexColor')
        when 'useSyntax' then atom.config.get('splash-ui.useSyntax')
        when 'debugMode' then atom.config.get('splash-ui.debugMode')

# shows value in console and returns value for use
toConsole = (key, val, returnVal) ->
    console.log('splash-ui :: ' + key + ' : ' + val) if getOption('debugMode')
    val if returnVal

# runs functions to generate files with LESS variables
setSplash(getOption('splashColor'))
setSyntax(getOption('useSyntax'))

# basic atom configuration handling
atom.config.onDidChange 'splash-ui.splashColor', ->
    color = getOption('splashColor')
    setSplash(toConsole('splash colour object', color, true))
    toConsole('splash colour Hex', color.toHexString(), false)
    console.log(color) if getOption('debugMode')
    atom.config.set('splash-ui.hexColor', rgbToHex(color.red, color.green, color.blue))

atom.config.onDidChange 'splash-ui.hexColor', ->
    hex = getOption('hexColor')
    isHex = checkHex(hex)
    rgb = hexToRgb(hex)
    color = getOption('splashColor')

    if isHex
        color.red = rgb.r
        color.green = rgb.g
        color.blue = rgb.b
        atom.config.set('splash-ui.splashColor', color)

atom.config.onDidChange 'splash-ui.useSyntax', ->
    setSyntax(toConsole('override syntax', getOption('useSyntax'), true))

atom.config.onDidChange 'splash-ui.debugMode', ->
    toConsole('debug mode', getOption('debugMode'), false)
