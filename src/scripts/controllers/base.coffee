{Controller} = require 'chaplin'
View = require 'views/index'
$ = require 'jquery'
mediator = require 'lib/mediator'

module.exports = class Base extends Controller

  beforeAction:
    '.*': ->
      # Do a raw get to get the CSRF token if we don't have it already
      return if mediator.token
      $.ajax(url: '/login').done (data) =>
        # Failed login attempt; store CSRF
        meta = $('<div/>').html(data).find('meta[name="csrf-token"]')
        # Store CSRF for later
        mediator.token = meta.attr('content')
