_ = require 'underscore'

# default options
defaultConfig = 
  showMillis: false
  showTimestamp: true
  showLogLavelName: true
  printObjFunc: require('util').inspect
  prefix: ""

# default level = debug
logLevel = 4

module.exports = class Logger
    
  @levels =
    error: 1
    warning: 2
    warn: 2
    info: 3
    log: 3
    debug: 4
    trace: 5
    
  @setLevel: (level, silent=false) ->
    levelName = null
    levelValue = null
    for name,val of Logger.levels
      if level == name or level == val
        levelName = name
        levelValue = val
        break;
    
    log = new this {prefix: 'basic-logger'} 
    if levelName? and levelValue?
      log.info "Setting log level to '"+levelName+"'" if !silent
      logLevel = levelValue
    else
      log.warn "Can't set log level to '"+level+"'. This level does not exist."     

  constructor: (config={}) ->
    @config = _.defaults config, defaultConfig

  padZeros: (num,digits) ->
    num = String num
    zerosToAdd = digits - num.length
    while zerosToAdd > 0
      num = '0'+num
      zerosToAdd = zerosToAdd - 1;
    num
  
  _log: (msg,levelName,args...) ->
    level = Logger.levels[levelName]
    if level <= logLevel
      date = new Date
      timestamp = date.getFullYear()+"-"+@padZeros((date.getMonth()+1),2)+"-"+@padZeros(date.getDate(),2)+" "+@padZeros(date.getHours(),2)+":"+@padZeros(date.getMinutes(),2)+":"+@padZeros(date.getSeconds(),2)
      timestamp += "."+@padZeros(date.getMilliseconds(),3) if @config.showMillis
      msg = @config.printObjFunc msg if typeof msg == "object"
      output = ''
      output += "[#{timestamp}]" if @config.showTimestamp
      output += " #{@config.prefix}" if @config.prefix != ""
      output += ' ('+levelName+') ' if @config.showLogLavelName
      output += msg
      args.unshift output
      return console.log.apply this, args
    else
      return -1
    
  error: (msg, args...) ->
    args.unshift(msg, 'error');
    @_log.apply this,args
    
  info: (msg, args...) ->
    args.unshift(msg, 'info');
    @_log.apply this,args

  log: (msg, args...) ->
    args.unshift(msg, 'log');
    @_log.apply this,args
    
  warn: (msg, args...) ->
    args.unshift(msg, 'warning');
    @_log.apply this,args
    
  warning: (msg, args...) ->
    args.unshift(msg, 'warning');
    @_log.apply this,args
    
  debug: (msg, args...) ->
    args.unshift(msg, 'debug');
    @_log.apply this,args
    
  trace: (msg, args...) ->
    args.unshift(msg, 'trace');
    @_log.apply this,args
