config          = require "../../config"
creds           = require "../../creds"
cookieParser    = require "cookie-parser"
session         = require "express-session"
passport        = require "passport"
TwitterStrategy = require("passport-twitter").Strategy

passport.serializeUser (user, done) -> done(null, user)
passport.deserializeUser (obj, done) -> done(null, obj)

passport.use new TwitterStrategy {
	consumerKey    : creds.twitter.client_id
	consumerSecret : creds.twitter.client_secret
	callbackURL    : "#{config.BASE_PATH}/auth/twitter/callback"
	},
	(token, tokenSecret, profile, done) ->

		session.twitterToken       = token
		session.twitterTokenSecret = tokenSecret

		process.nextTick -> return done(null, profile)

auth         = passport.authenticate('twitter')
authCallback = passport.authenticate('twitter', { successRedirect: '/auth/twitter/callback/done', failureRedirect: '/auth/twitter/error' })

renderCallback = (req, res) ->
	if req.user
		data =
			token       : session.twitterToken
			tokenSecret : session.twitterTokenSecret
			provider    : req.user.provider
			name        : req.user.displayName
			id          : req.user.id
			avatar      : req.user.photos[0].value

	res.render "auth/callback", data or {}

error = (req, res) ->
	res.render "errors/authError"

setup = (app) ->
	app.use cookieParser()
	app.use session({ secret: 'what up' })
	app.use passport.initialize()
	app.use passport.session()

	app.get '/auth/twitter', auth
	app.get '/auth/twitter/callback', authCallback
	app.get '/auth/twitter/callback/done', renderCallback
	app.get '/auth/twitter/error', error

module.exports = setup
