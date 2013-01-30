module.exports = (match) ->
  match '', 'product#list', name: 'list'
  match ':tag', 'product#tag', name: 'tag'
  match 'account/login', 'login#show', name: 'login'
