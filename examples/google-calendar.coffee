REM = require '../rem'
fs = require 'fs'
{ask} = require './utils'
keys = JSON.parse fs.readFileSync __dirname + '/keys.json'

# Google Calendar
# ===============

gcal = new REM 'google-calendar', '2',
	key: 'anonymous'
	secret: 'anonymous'

gcal.startOAuth (url, results) ->
	console.log "Visit:", url
	ask "Please enter the verification code: ", /[\w\d]+/, (verifier) ->
		gcal.completeOAuth verifier, (results) ->
			# Authenticated REST calls.
			gcal.get '/default/allcalendars/full', {}, (err, action) ->
				if err then console.log err; return

				console.log 'Your calendars:'
				for cal in action.json.data.items
					console.log ' * ', cal.title