config = require "./config"
creds  = module.exports

if config.PRODUCTION

	creds.twitter =
		client_id     : "ADD YO STUFF HERE"
		client_secret : "ADD YO STUFF HERE"

else

	creds.twitter =
		client_id     : "ADD YO STUFF HERE"
		client_secret : "ADD YO STUFF HERE"
