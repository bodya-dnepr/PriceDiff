App.Routers.MainRouter = Backbone.Marionette.AppRouter.extend
  routes:
    '!countries': 'countries'
    '!cities':    'cities'
    '!countries/:id/cities': 'cities'
  countries: ->
    collection = new App.Collections.Country
    collection.fetch
      success: (collection, data, xhr) ->
        countries = new App.Views.Countries collection: collection
        App.content.show(countries)
  cities: (id) ->
    collection = new App.Collections.City
    collection.country = {id: id} if !!id
    collection.fetch
      success: (collection, data, xhr) ->
        countries = new App.Views.Cities collection: collection
        App.content.show(countries)
