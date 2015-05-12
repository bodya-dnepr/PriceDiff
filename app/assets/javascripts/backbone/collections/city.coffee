country_id = null
App.Collections.City = Backbone.Collection.extend
  initialize: (val) ->
    throw "country_id required" if !val
    country_id = val
    @__defineSetter__ "country_id", (val) -> country_id = val
  model: App.Models.City
  url: ->
    "/countries/#{country_id}/cities"

