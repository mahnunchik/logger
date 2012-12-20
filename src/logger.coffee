_ = require 'underscore'

# default options
defaultConfig = 
  showMillis: false
  showTimestamp: true
  showLogLevelName: true
  printObjFunc: require('util').inspect
  prefix: ""

# default level = debug
logLevel = 5

module.exports = class Logger
  @levels = 
    none: 
      level: 0
      name: 'none'
    error: 
      method: 'error'
      level: 1
      name: 'error'
    err: 
      method: 'error'
      level: 1
      name: 'error'
    warn: 
      method: 'warn'
      level: 2
      name: 'warn'
    warning:
      method: 'warn'
      level: 2
      name: 'warn'
    info: 
      method: 'info'
      level: 3
      name: 'info'
    log: 
      method: 'log'
      level: 4
      name: 'log'
    debug: 
      method: 'log'
      level: 5
      name: 'debug'
    trace: 
      method: 'trace'
      level: 6
      name: 'trace'

  @setLevel: (level, silent=false) ->
    levelName = null
    levelValue = null
    for name, val of Logger.levels
      if level == val.level or level == val.name or level == name
        levelName = val.name
        levelValue = val.level
        break
    
    log = new this {prefix: 'basic-logger'} 
    if levelName? and levelValue?
      log.info "Setting log level to '#{levelName}'" if !silent
      logLevel = levelValue
    else
      log.warn "Can't set log level to '#{level}'. This level does not exist."

  @logger: (config)->
    new @(config)   

  constructor: (config={}) ->
    if _.isString config
      config =
        prefix: config
    @config = _.defaults config, defaultConfig

  padZeros: (num,digits) ->
    num = String num
    zerosToAdd = digits - num.length
    while zerosToAdd > 0
      num = '0'+num
      zerosToAdd = zerosToAdd - 1;
    num
  
  _log: (level, levelName, methodName, msg, args...) ->
    if level <= logLevel
      msg = @config.printObjFunc msg if typeof msg == "object"
      output = ''
      if @config.showTimestamp
        date = new Date
        timestamp = "#{date.getFullYear()}-#{@padZeros((date.getMonth()+1),2)}-#{@padZeros(date.getDate(),2)} #{@padZeros(date.getHours(),2)}:#{@padZeros(date.getMinutes(),2)}:#{@padZeros(date.getSeconds(),2)}"
        timestamp += ".#{@padZeros(date.getMilliseconds(),3)}" if @config.showMillis
        output += "[#{timestamp}]"
      output += " #{@config.prefix}" if @config.prefix != ""
      output += if @config.showLogLevelName then " (#{levelName}) " else " "
      output += msg
      args.unshift output
      return console[methodName].apply @, args
    else
      return -1

  _.each @.levels, (item, propName)=>
    if item.method?
      @::[propName] = (msg, args...)->
        args.unshift(item.level, item.name, item.method, msg)
        @_log.apply @, args
