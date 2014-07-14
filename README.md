# Twitter oauth app

Quick and simple node (express + coffeescript) app with Twitter oauth set up, nice for quick prototypes.

### Setup

1. `$ git clone git@github.com:neilcarpenter/twitter-oauth-app.git`
2. `$ cd twitter-oauth-app`
3. `$ npm install`
4. Go [here](https://apps.twitter.com/) and set up a Twitter application, setting website URL as `http://127.0.0.1:3000/`
5. Add generated Twitter app credentials to `app/creds.coffee` (after the `else`)
6. `$ coffee app/server.coffee`
7. Go to [http://127.0.0.1:3000/](http://127.0.0.1:3000/) and enjoy

*App code structure thanks to -> [https://github.com/focusaurus/express_code_structure*](https://github.com/focusaurus/express_code_structure)*
