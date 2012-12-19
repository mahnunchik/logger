logger = require('./src/logger').logger
  showMillis: false
  showTimestamp: true
  showLogLavelName: true
  prefix: "rrr"

require('./src/logger').setLevel(6)

logger.warn(12345)

assert = require 'assert'
console.log 'e', assert.equal


