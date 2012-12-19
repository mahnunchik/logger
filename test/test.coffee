assert = require 'assert'
logger = require '../'

log = null


describe 'Logger', ->
	describe "when instantiating a new logger", ->
			describe "with a custom config showMillis = true", ->
				beforeEach () ->
					config = 
						showMillis: true
					log = new logger config
				afterEach ()->
					log = null
				
				it "the value of the logger config for showMillis is true and showTimestamp is still true", () ->
					assert.equal log.config.showMillis,true
					assert.equal log.config.showTimestamp,true
					
			describe "with a custom config showMillis = false", ->
				beforeEach () ->
					config = 
						showMillis: false
					log = new logger config
				afterEach ()->
					log = null
				
				it "the value of the logger config for showMillis is false and showTimestamp is still true", () ->
					assert.equal log.config.showMillis,false
					assert.equal log.config.showTimestamp,true
				
		describe "when padding a one-digit number with zeros to 2 digits", ->
			beforeEach () ->
				log = new logger
			afterEach ()->
					log = null
				
			it "the result is the one-digits number left-padded with a zero", () ->
				assert.equal log.padZeros(3,2),'03'
				
		describe "when logging a message with setting the log level to 2 (warning)", ()->
			beforeEach () ->
				logger.setLevel 2
				config = 
					showMillis: true
					prefix: "Test"
				log = new logger config
			afterEach ()->
					log = null
			
			it "the warning method doesn't throw an error", () ->
				assert.doesNotThrow () ->
					log.warn "test message"
				assert.notEqual log.warn("test message"),-1
			
			it "the info method returns -1", () ->
				assert.equal log.info("test message"),-1
