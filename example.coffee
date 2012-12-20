Logger = require('./src/logger')

#Default config
log1 = new Logger()

log1.error('Default config', 'this error message is shown')
log1.warn('Default config', 'this warn message is shown')
log1.info('Default config', 'this info message is shown')
log1.log('Default config', 'this log message is shown')
log1.debug('Default config', 'this debug message is shown')
log1.trace('Default config', 'this trace message is not shown')

config =
  showMillis: true
  showTimestamp: true
  showLogLevelName: true
  prefix: "Example"

#Custom config
log2 = new Logger(config)

log2.log('Custom config', 'this message is shown')
log2.trace('Custom config', 'this message is not shown')

#Factory method
log3 = Logger.logger("Factory method")

log3.log('Custom config', 'this message is shown')
log3.trace('Custom config', 'this message is not shown')

#set global log level
Logger.setLevel(6)

log3.log('Custom config, log lavel 6', 'this message is shown')
log3.trace('Custom config, log lavel 6 this message is shown')


#set global log level
Logger.setLevel(1)

log1.error('Default config log lavel 6', 'this error message is shown')
log1.warn('Default config log lavel 6', 'this warn message is not shown')
log1.info('Default config log lavel 6', 'this info message is not shown')
log1.log('Default config log lavel 6', 'this log message is not shown')
log1.debug('Default config log lavel 6', 'this debug message is not shown')
log1.trace('Default config log lavel 6 this trace message is not shown')

#set global log level
Logger.setLevel(0)

log1.error('Default config log lavel 0', 'this error message is not shown')



