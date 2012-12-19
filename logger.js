// Generated by CoffeeScript 1.4.0
var Logger, defaultConfig, logLevel, _,
  __slice = [].slice;

_ = require('underscore');

defaultConfig = {
  showMillis: false,
  showTimestamp: true,
  showLogLavelName: true,
  printObjFunc: require('util').inspect,
  prefix: ""
};

logLevel = 5;

module.exports = Logger = (function() {

  Logger.levels = {
    error: 1,
    warn: 2,
    info: 3,
    log: 4,
    debug: 5,
    trace: 6
  };

  Logger.setLevel = function(level, silent) {
    var levelName, levelValue, log, name, val, _ref;
    if (silent == null) {
      silent = false;
    }
    levelName = null;
    levelValue = null;
    _ref = Logger.levels;
    for (name in _ref) {
      val = _ref[name];
      if (level === name || level === val) {
        levelName = name;
        levelValue = val;
        break;
      }
    }
    log = new this({
      prefix: 'basic-logger'
    });
    if ((levelName != null) && (levelValue != null)) {
      if (!silent) {
        log.info("Setting log level to '" + levelName + "'");
      }
      return logLevel = levelValue;
    } else {
      return log.warn("Can't set log level to '" + level + "'. This level does not exist.");
    }
  };

  Logger.logger = function(config) {
    return new this(config);
  };

  function Logger(config) {
    if (config == null) {
      config = {};
    }
    this.config = _.defaults(config, defaultConfig);
  }

  Logger.prototype.padZeros = function(num, digits) {
    var zerosToAdd;
    num = String(num);
    zerosToAdd = digits - num.length;
    while (zerosToAdd > 0) {
      num = '0' + num;
      zerosToAdd = zerosToAdd - 1;
    }
    return num;
  };

  Logger.prototype._log = function() {
    var args, date, level, levelName, msg, output, timestamp;
    levelName = arguments[0], msg = arguments[1], args = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
    level = Logger.levels[levelName];
    if ((level != null) && level <= logLevel) {
      date = new Date;
      timestamp = "" + (date.getFullYear()) + "-" + (this.padZeros(date.getMonth() + 1, 2)) + "-" + (this.padZeros(date.getDate(), 2)) + " " + (this.padZeros(date.getHours(), 2)) + ":" + (this.padZeros(date.getMinutes(), 2)) + ":" + (this.padZeros(date.getSeconds(), 2));
      if (this.config.showMillis) {
        timestamp += "." + (this.padZeros(date.getMilliseconds(), 3));
      }
      if (typeof msg === "object") {
        msg = this.config.printObjFunc(msg);
      }
      output = '';
      if (this.config.showTimestamp) {
        output += "[" + timestamp + "]";
      }
      if (this.config.prefix !== "") {
        output += " " + this.config.prefix;
      }
      output += this.config.showLogLavelName ? " (" + levelName + ") " : " ";
      output += msg;
      args.unshift(output);
      return console[levelName].apply(this, args);
    } else {
      return -1;
    }
  };

  Logger.prototype.error = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('error', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.warn = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('warn', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.warning = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('warn', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.info = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('info', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.log = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('log', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.debug = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('log', msg);
    return this._log.apply(this, args);
  };

  Logger.prototype.trace = function() {
    var args, msg;
    msg = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    args.unshift('trace', msg);
    return this._log.apply(this, args);
  };

  return Logger;

})();
