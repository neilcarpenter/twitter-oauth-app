# Here's a set of routes for the full HTML pages on our site
express = require 'express'
content = require '../content/all.json'

home = (req, res) ->
	res.render "site/home", content.home

about = (req, res) ->
	res.render "site/about"

setup = (app) ->
	app.get '/', home
	app.get '/about', about

module.exports = setup
