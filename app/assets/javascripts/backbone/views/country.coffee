App.Views.Country = Backbone.Marionette.ItemView.extend
  template: "countries/show"
  tagName: "paper-item"
  events:
    'click': 'openCities'
  openCities: ->
    citiesCollection = new App.Collections.City(@model.id)
    citiesCollection.fetch
      success: (collection, data) ->
        view = new App.Views.Cities collection: collection
        App.content.show(view)
