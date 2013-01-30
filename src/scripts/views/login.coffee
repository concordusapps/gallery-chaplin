$ = require 'jquery'
Chaplin = require 'chaplin'
mediator = require 'lib/mediator'

module.exports = class Login extends Chaplin.View

  container: '#container'

  containerMethod: 'html'

  getTemplateFunction: -> require 'templates/login'

  id: 'login'

  events:
    'submit form': (event) ->
      event.preventDefault()
      $.ajax
        type: 'post'
        url: '/sessions'
        data:
          authenticity_token: mediator.token
          email: @$('input[name="email"]').val()
          password: @$('input[name="password"]').val()
          commit: 'Log in'
      .done =>
        # 200 OK -- login failed
        @$('input').val ''  # Clear form
      .fail =>
        # 302 REDIRECT -- login succeeded
        mediator.authenticated = yes
        @publishEvent '!router:route', ''
