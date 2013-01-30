Controller = require 'controllers/base'
View = require 'views/index'
$ = require 'jquery'
mediator = require 'lib/mediator'

module.exports = class Protected extends Controller

  beforeAction:
    '.*': ->
      # Do a raw get to check login status
      console.log 'auth: ', mediator.authenticated
      return if mediator.authenticated
      $.get('/api/products.json').fail =>
        # Redirect to login page
        @redirectToRoute 'login'
      .done =>
        # Say we're logged in
        mediator.authenticated = yes
