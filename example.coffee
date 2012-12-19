logger = require('./src/logger').logger
  showMillis: false
  showTimestamp: true
  showLogLavelName: true
  prefix: "rrr"

require('./src/logger').setLevel(6)

logger.warn(12345)


