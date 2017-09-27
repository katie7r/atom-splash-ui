module.exports =

# returns true if matches hex pattern
checkHex = (hex) ->
    return false unless hex
    reg = /^#[\da-fA-F]{3,6}$/
    str = hex
    true if str.match reg

# bool trigger, specifies whether or not to use splash color
setSplash = (trigger) ->
    color = if trigger then getOption('splashColor') else '#F8F9FA' # @oc-gray-0
    setColor(color)

# string splash, writes hex colour to file
setColor = (splash) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-splash.less'
    splashHex = '#' + splash.replace('#', '')
    splashHex = '#F8F9FA' unless checkHex(splashHex)
    content = "@splash-color: #{splashHex};\n"
    fs.writeFileSync writePath, content

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
        when 'useSplash' then atom.config.get('splash-ui.useSplash')
        when 'splashColor' then atom.config.get('splash-ui.splashColor')
        when 'useSyntax' then atom.config.get('splash-ui.useSyntax')

# runs functions to generate files with LESS variables
setSplash(getOption('useSplash'))
setColor(getOption('splashColor'))
setSyntax(getOption('useSyntax'))

# basic atom configuration handling
atom.config.onDidChange 'splash-ui.useSplash', ->
  setSplash(getOption('useSplash'))

atom.config.onDidChange 'splash-ui.splashColor', ->
  setColor(getOption('splashColor'))

atom.config.onDidChange 'splash-ui.useSyntax', ->
  setSyntax(getOption('useSyntax'))
