Protected = require 'controllers/protected'
View = require 'views/list'
Collection = require 'collections/product'

module.exports = class Index extends Protected

  beforeAction:
    'list|tag': ->
      @compose 'product:list', compose: ->
        composition = {}
        composition.collection = new Collection
        composition.view = new View {collection: composition.collection}
        composition.collection.fetch()
        composition

  list: ->  # All done in the before action

  tag: (param) ->
    @publishEvent '!product:filter', param.tag
