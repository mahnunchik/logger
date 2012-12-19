_ = require 'underscore'

# default options
defaultConfig = 
  showMillis: false
  showTimestamp: true
  showLogLavelName: true
  printObjFunc: require('util').inspect
  prefix: ""

# default level = debug
logLevel = 5

module.exports = class Logger
    
  @levels =
    error: 1
    warn: 2
    info: 3
    log: 4
    debug: 5
    trace: 6
    
  @setLevel: (level, silent=false) ->
    levelName = null
    levelValue = null
    for name,val of Logger.levels
      if level == name or level == val
        levelName = name
        levelValue = val
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
    @config = _.defaults config, defaultConfig

  padZeros: (num,digits) ->
    num = String num
    zerosToAdd = digits - num.length
    while zerosToAdd > 0
      num = '0'+num
      zerosToAdd = zerosToAdd - 1;
    num
  
  _log: (levelName, msg, args...) ->
    level = Logger.levels[levelName]
    if level? and level <= logLevel
      date = new Date
      timestamp = "#{date.getFullYear()}-#{@padZeros((date.getMonth()+1),2)}-#{@padZeros(date.getDate(),2)} #{@padZeros(date.getHours(),2)}:#{@padZeros(date.getMinutes(),2)}:#{@padZeros(date.getSeconds(),2)}"
      timestamp += ".#{@padZeros(date.getMilliseconds(),3)}" if @config.showMillis

      msg = @config.printObjFunc msg if typeof msg == "object"
      output = ''
      output += "[#{timestamp}]" if @config.showTimestamp
      output += " #{@config.prefix}" if @config.prefix != ""
      output += if @config.showLogLavelName then " (#{levelName}) " else " "
      output += msg
      args.unshift output
      return console[levelName].apply @, args
    else
      return -1
    
  error: (msg, args...) ->
    args.unshift('error', msg)
    @_log.apply @, args
    
  warn: (msg, args...) ->
    args.unshift('warn', msg)
    @_log.apply @, args
    
  warning: (msg, args...) ->
    args.unshift('warn', msg)
    @_log.apply @, args

  info: (msg, args...) ->
    args.unshift('info', msg)
    @_log.apply @, args

  log: (msg, args...) ->
    args.unshift('log', msg)
    @_log.apply @, args
    
  debug: (msg, args...) ->
    args.unshift('log', msg)
    @_log.apply @, args
    
  trace: (msg, args...) ->
    args.unshift('trace', msg)
    @_log.apply @, args
