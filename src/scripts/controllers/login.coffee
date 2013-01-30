Controller = require 'controllers/base'
View = require 'views/login'

module.exports = class Login extends Controller

  show: ->
    @view = new View
    @view.render()
