App.Views.Country = Backbone.Marionette.ItemView.extend
  template: "countries/show"
  tagName: "paper-item"
  events:
    'click': 'openCities'
  openCities: ->
    App.router.navigate("!countries/#{@model.id}/cities", {trigger: true})
