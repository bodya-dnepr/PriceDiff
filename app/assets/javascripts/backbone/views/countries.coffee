# index
App.Views.Countries = Backbone.Marionette.CompositeView.extend
  template: 'countries/index'
  getChildView: -> App.Views.Country
  childViewContainer: 'section'

# show partial
App.Views.Country = Backbone.Marionette.ItemView.extend
  template: "countries/show"
  tagName: "paper-item"
  events:
    'click': 'openCities'
  openCities: ->
    App.router.navigate("!countries/#{@model.id}/cities", {trigger: true})

App.Views.CountryEdit = Marionette.FormView.extend

