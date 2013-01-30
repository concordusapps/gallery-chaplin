_ = require 'underscore'
Chaplin = require 'chaplin'

module.exports = class Products extends Chaplin.Collection

  # Mixin a synchronization state machine.
  _(@prototype).extend Chaplin.SyncMachine

  # URL that the data resides on.
  # This is the URL that HTTP methods will be run against.
  url: '/api/products.json'

  fetch: ->
    # Initiate a syncing operation; magic for selectors
    @beginSync()
    request = super
    # Facilitates the sync machine by letting those who care know that
    # the request is done and is successful (or is failure).
    request.done => @finishSync()
    request.fail => @abortSync()
    request
