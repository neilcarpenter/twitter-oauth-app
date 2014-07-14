creds      = require '../../creds'
twitter    = require 'twitter'
bodyParser = require 'body-parser'

getTweets = (req, res) ->

	params =
		user_id          : req.body.user_id
		count            : 5
		include_entities : true

	twit = new twitter
		consumer_key        : creds.twitter.client_id
		consumer_secret     : creds.twitter.client_secret
		access_token_key    : req.body.token
		access_token_secret : req.body.tokenSecret

	twit.get '/statuses/user_timeline.json', params, (data) ->
		res.json tweets : data

setup = (app) ->
	app.use bodyParser()

	app.post '/api/twitter/getTweets', getTweets

module.exports = setup
