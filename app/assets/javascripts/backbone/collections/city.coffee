App.Collections.City = Backbone.Collection.extend
  initialize: (val) ->
    @country ||= {}
    @country.id = val if !!val
  model: App.Models.City
  url: ->
    if !!@country.id
      return "/countries/#{@country.id}/cities"
    else
      return "/cities"
