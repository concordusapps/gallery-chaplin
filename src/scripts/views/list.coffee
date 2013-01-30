Chaplin = require 'chaplin'

class Item extends Chaplin.View

  getTemplateFunction: -> require 'templates/item'

  tagName: 'li'

  bindings:
    '.thumbnail':
      observe: 'image_url_thumb'
      attributes: [
        name: 'src'
      ]

  afterRender: ->
    super
    @stickit()

class TagList extends Chaplin.View

  getTemplateFunction: -> require 'templates/tags'

  getTemplateData: ->
    tags: @options.tags

  initialize: (@options) ->

module.exports = class List extends Chaplin.CollectionView

  getTemplateFunction: -> require 'templates/list'

  container: '#container'

  containerMethod: 'html'

  id: 'list'

  itemView: Item

  loadingSelector: '#loading'

  listSelector: '.items'

  _tag: null

  _tags: []

  initialize: ->
    super
    @subscribeEvent '!product:filter', (@_tag) ->
      return unless @collection.syncState() is 'synced'
      @filter @filterer, @filterCallback

    # Determine list of tags..
    @listenTo @collection, 'synced', ->
      for model in @collection.models
        for tag in model.get('tag_list')
          continue if tag in @_tags
          @_tags.push tag

      @subview 'tags', new TagList
        tags: @_tags,
        container: @$ '.tag-container'

      @subview('tags').render()

  filterer: (model) =>
    if @_tag then @_tag in model.get 'tag_list'
    else true
